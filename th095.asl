// Please move both of your "scoreth095.dat" and "bestshot" directory to other directory before running.

state("th095", "ver 1.02a")
{
  int unknown : 0x0c4df4;
}

// English Patched - https://en.touhouwiki.net/wiki/Shoot_the_Bullet/English_patch
state("th095e", "ver 1.02a with English Patch v1.1")
{
  int unknown : 0x0c4df4;
}

startup
{
  var info_base_addr = 0x4c4e78;

  vars.split_delay = 5;
  vars.split_counter = 0;
  vars.info_base_value = 0;

  vars.getInfoBaseValue = (Func<Process, int>)((proc) => {
    return proc.ReadValue<int>((IntPtr)info_base_addr);
  });

  vars.getClearFlagAddr = (Func<Process, int, int, IntPtr>)((proc, level, scene) => {
    var idx = (level - 1) * 10 + scene - 1;
//    print("lv:"+level.ToString()+", sn:"+scene.ToString()+", idx:"+idx.ToString());
    var flag_addr = vars.info_base_value + idx * 0x60 + 0x04b0;
//    print("info_base: "+vars.info_base_value.ToString("X"));
//    print("flg_addr: "+flg_addr.ToString("X"));
    return (IntPtr)flag_addr;
  });

  vars.createMemoryWatcherList = (Func<Process, MemoryWatcherList>)((proc) => {
    return new MemoryWatcherList {
      new MemoryWatcher<int>(vars.getClearFlagAddr(game,  1, 6)) { Name = "Level 1" },
      new MemoryWatcher<int>(vars.getClearFlagAddr(game,  2, 6)) { Name = "Level 2" },
      new MemoryWatcher<int>(vars.getClearFlagAddr(game,  3, 8)) { Name = "Level 3" },
      new MemoryWatcher<int>(vars.getClearFlagAddr(game,  4, 9)) { Name = "Level 4" },
      new MemoryWatcher<int>(vars.getClearFlagAddr(game,  5, 8)) { Name = "Level 5" },
      new MemoryWatcher<int>(vars.getClearFlagAddr(game,  6, 8)) { Name = "Level 6" },
      new MemoryWatcher<int>(vars.getClearFlagAddr(game,  7, 8)) { Name = "Level 7" },
      new MemoryWatcher<int>(vars.getClearFlagAddr(game,  8, 8)) { Name = "Level 8" },
      new MemoryWatcher<int>(vars.getClearFlagAddr(game,  9, 8)) { Name = "Level 9" },
      new MemoryWatcher<int>(vars.getClearFlagAddr(game, 10, 8)) { Name = "Level 10" },
      new MemoryWatcher<int>(vars.getClearFlagAddr(game, 11, 8)) { Name = "Level EX" },
    };
  });

}

init
{
  refreshRate = 60;

  vars.info_base_value = vars.getInfoBaseValue(game);
  vars.watchers = vars.createMemoryWatcherList(game);
}

update
{
  var current_info_base_value = vars.getInfoBaseValue(game);
  if (vars.info_base_value != current_info_base_value) {
//    print("old base: "+vars.info_base_value.ToString("X"));
//    print("new base: "+current_info_base_value.ToString("X"));
    vars.info_base_value = current_info_base_value;

    vars.watchers = vars.createMemoryWatcherList(game);
  }

  vars.watchers.UpdateAll(game);
}

start
{
  // when 1-1 is not cleared and start playing
  var flg_1_1 = memory.ReadValue<int>((IntPtr)vars.getClearFlagAddr(game,  1, 1));
  return flg_1_1 == 0 && old.unknown == 0 && current.unknown != 0;
}

split
{
  if (vars.split_counter >= vars.split_delay) {
    vars.split_counter = 0;
    return true;
  } else if (vars.split_counter > 0) {
    ++vars.split_counter;
    return false;
  } else {
    foreach (var w in vars.watchers) {
      if (w.Changed) {
        vars.split_counter = 1;
        return false;
      }
    }
  }
}

reset
{
}

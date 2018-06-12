state("th095", "ver 1.02a")
{
  int unknown : 0x0c4df4;
}

startup
{
  var info_base_addr = 0x4c4e78;

  vars.getClearFlagAddr = (Func<Process, int, int, IntPtr>)((proc, level, scene) => {
    var idx = (level - 1) * 10 + scene - 1;
//    print("lv:"+level.ToString()+", sn:"+scene.ToString()+", idx:"+idx.ToString());
    var info_base = proc.ReadValue<int>((IntPtr)info_base_addr);
    var flag_addr = info_base + idx * 0x60 + 0x04b0;
//    print("info_base: "+info_base.ToString("X"));
//    print("flg_addr: "+flg_addr.ToString("X"));
    return (IntPtr)flag_addr;
  });

}

init
{
  refreshRate = 60;

  vars.watchers = new MemoryWatcherList {
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
}

update
{
  vars.watchers.UpdateAll(game);
}

start
{
  // when 1-1 is not cleared and start playing
  var flg_1_1 = memory.ReadValue<int>((IntPtr)vars.getClearFlagAddr(game,  1, 1));
  if (flg_1_1 == 0 && old.unknown == 0 && current.unknown != 0)
    return true;
}

split
{
  foreach (var w in vars.watchers) {
    if (w.Changed)
      return true;
  }
}

reset
{
}

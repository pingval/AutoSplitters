state("th095", "ver 1.02a")
{
  int unknown : 0x0c4df4;
  int st_base : 0x0bdec8;
  int norma_base : 0x0c4e70;
}

// English Patched - https://en.touhouwiki.net/wiki/Shoot_the_Bullet/English_patch
state("th095e", "ver 1.02a with English Patch v1.1")
{
  int unknown : 0x0c4df4;
  int st_base : 0x0bdec8;
  int norma_base : 0x0c4e70;
}

startup
{
  vars.st_offset = 0xfc;
  vars.curr_offset = 0x29e4;
  vars.norma_offset = 0x29ec;
}

init
{
  refreshRate = 60;

  vars.st    = new MemoryWatcher<int>((IntPtr)(current.st_base + vars.st_offset));
  vars.curr  = new MemoryWatcher<int>((IntPtr)(current.norma_base + vars.curr_offset));
  vars.norma = new MemoryWatcher<int>((IntPtr)(current.norma_base + vars.norma_offset));
}

update
{
  if (old.st_base != current.st_base) {
//     print("awsdfawwd");
//     print((current.st_base + 0xfc).ToString("X"));
    vars.st    = new MemoryWatcher<int>((IntPtr)(current.st_base + vars.st_offset));
  }
  if (old.norma_base != current.norma_base) {
    vars.curr  = new MemoryWatcher<int>((IntPtr)(current.norma_base + vars.curr_offset));
    vars.norma = new MemoryWatcher<int>((IntPtr)(current.norma_base + vars.norma_offset));
  }

  vars.st.Update(game);
  vars.curr.Update(game);
  vars.norma.Update(game);
}

start
{
  return old.unknown == 0 && current.unknown != 0;
}

split
{
//  print("st: " + vars.st.Current.ToString("X"));
//  print("norma: " + vars.curr.Current.ToString() + "/" + vars.norma.Current.ToString());
//   return (vars.curr.Old < vars.norma.Current && vars.curr.Current == vars.norma.Current);
  return (vars.st.Old & 0x40) == 0 && (vars.st.Current & 0x40) != 0;
}

reset
{
}

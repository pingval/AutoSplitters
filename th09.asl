state("th09", "ver 1.00")
{
  int wins_1p : 0x09ee98;
  int wins_2p : 0x09ee9c;
  int st : 0x09eec4;
}

state("th09", "ver 1.50a")
{
  int wins_1p : 0x0a7e98;
  int wins_2p : 0x0a7e9c;
  int st : 0x0a7ec4;
}

// English Patched - https://en.touhouwiki.net/wiki/Phantasmagoria_of_Flower_View/English_Patch
state("th09e", "ver 1.50a with English Patch v1.1")
{
  int wins_1p : 0x0a7e98;
  int wins_2p : 0x0a7e9c;
  int st : 0x0a7ec4;
}

init
{
  refreshRate = 60;

  int module_size = modules.First().ModuleMemorySize;
  print("Game Process Name: " + game.ProcessName);
  print("Main Module Size: " + module_size.ToString());
  switch (module_size) {
  case 909312:
    version = "ver 1.00";
    break;
  default:
    version = "ver 1.50a";
    break;
  }
}

update
{
//  print(current.wins_1p.ToString() + " - " + current.wins_2p.ToString());
}

start
{
  return old.st == 0 && current.st != 0;
}

split
{
  return old.wins_1p == 0 && current.wins_1p > 0;
}

// This code malfunctions occasionally.
reset
{
//  return old.st != 0 && current.st == 0;
}

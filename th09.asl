state("th09", "ver 1.50a")
{
  int wins_1p : 0x0a7e98;
  int wins_2p : 0x0a7e9c;
  byte difficulty : 0x0a7ec4;
}

init
{
  refreshRate = 60;
}

update
{
//  print(current.wins_1p.ToString() + " - " + current.wins_2p.ToString());
}

start
{
  return old.difficulty == 0 && current.difficulty != 0;
}

split
{
  return old.wins_1p == 0 && current.wins_1p > 0;
}

reset
{
  return (current.wins_1p == 0
          && old.difficulty != 0 && current.difficulty == 0);
}

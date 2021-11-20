state("th07", "ver 1.00b")
{
}

startup
{
  vars.DEBUG = false;

  vars.stage_name_table = new string[] { "-", "1", "2", "3", "4", "5", "6", "Extra", "Phantasm", };
  vars.boss_appears_re = new System.Text.RegularExpressions.Regex("(?<=\\\x7d ).*(?= Appears$)");

  vars.already_playscreen = false;
  vars.duration_before_playscreen = TimeSpan.Zero;

  // val, settingkey, label, tooltip, enabled, visible
  var split_defs = new List<Tuple<int, string, string, string, bool, bool>> {
    Tuple.Create(-1, "<Parent> [Extra]", "Extra", "", false, true),
    Tuple.Create(0, "[Extra]{Boss Appears} Chen Appears", "Chen Appears", "", true, true),
    Tuple.Create(116, "[Extra]{Nonspell} Chen Nonspell 1", "Chen Nonspell 1", "", true, true),
    Tuple.Create(116, "[Extra]{Spell Card} Oni Sign \"Blue Oni Red Oni\"", "Oni Sign \"Blue Oni Red Oni\"", "", true, true),
    Tuple.Create(117, "[Extra]{Spell Card} Kishin \"Soaring Bishamonten\"", "Kishin \"Soaring Bishamonten\"", "", true, true),
    Tuple.Create(117, "[Extra]{Boss Appears} Ran Appears", "Ran Appears", "", true, true),
    Tuple.Create(118, "[Extra]{Nonspell} Ran Nonspell 1", "Ran Nonspell 1", "", true, true),
    Tuple.Create(118, "[Extra]{Spell Card} Shikigami \"Senko Thoughtful Meditation\"", "Shikigami \"Senko Thoughtful Meditation\"", "", true, true),
    Tuple.Create(119, "[Extra]{Nonspell} Ran Nonspell 2", "Ran Nonspell 2", "", true, true),
    Tuple.Create(119, "[Extra]{Spell Card} Shikigami \"Banquet of the Twelve General Gods\"", "Shikigami \"Banquet of the Twelve General Gods\"", "", true, true),
    Tuple.Create(120, "[Extra]{Nonspell} Ran Nonspell 3", "Ran Nonspell 3", "", true, true),
    Tuple.Create(120, "[Extra]{Spell Card} Shiki Brilliance \"Kitsune-Tanuki Youkai Laser\"", "Shiki Brilliance \"Kitsune-Tanuki Youkai Laser\"", "", true, true),
    Tuple.Create(121, "[Extra]{Nonspell} Ran Nonspell 4", "Ran Nonspell 4", "", true, true),
    Tuple.Create(121, "[Extra]{Spell Card} Shiki Brilliance \"Charming Siege from All Sides\"", "Shiki Brilliance \"Charming Siege from All Sides\"", "", true, true),
    Tuple.Create(122, "[Extra]{Nonspell} Ran Nonspell 5", "Ran Nonspell 5", "", true, true),
    Tuple.Create(122, "[Extra]{Spell Card} Shiki Brilliance \"Princess Tenko -Illusion-\"", "Shiki Brilliance \"Princess Tenko -Illusion-\"", "", true, true),
    Tuple.Create(123, "[Extra]{Nonspell} Ran Nonspell 6", "Ran Nonspell 6", "", true, true),
    Tuple.Create(123, "[Extra]{Spell Card} Shiki Shot \"Ultimate Buddhist\"", "Shiki Shot \"Ultimate Buddhist\"", "", true, true),
    Tuple.Create(124, "[Extra]{Nonspell} Ran Nonspell 7", "Ran Nonspell 7", "", true, true),
    Tuple.Create(124, "[Extra]{Spell Card} Shiki Shot \"Unilateral Contact\"", "Shiki Shot \"Unilateral Contact\"", "", true, true),
    Tuple.Create(125, "[Extra]{Nonspell} Ran Nonspell 8", "Ran Nonspell 8", "", true, true),
    Tuple.Create(125, "[Extra]{Spell Card} Shikigami \"Chen\"", "Shikigami \"Chen\"", "", true, true),
    Tuple.Create(126, "[Extra]{Spell Card} \"Kokkuri-san's Contract\"", "\"Kokkuri-san's Contract\"", "", true, true),
    Tuple.Create(127, "[Extra]{Spell Card} Illusion God \"Descent of Izuna-Gongen\"", "Illusion God \"Descent of Izuna-Gongen\"", "", true, true),
    Tuple.Create(-1, "<Parent> [Phantasm]", "Phantasm", "", true, true),
    Tuple.Create(0, "[Phantasm]{Boss Appears} Ran Appears", "Ran Appears", "", true, true),
    Tuple.Create(128, "[Phantasm]{Nonspell} Ran Nonspell 1", "Ran Nonspell 1", "", true, true),
    Tuple.Create(128, "[Phantasm]{Spell Card} Shikigami \"Protection of Zenki and Goki\"", "Shikigami \"Protection of Zenki and Goki\"", "", true, true),
    Tuple.Create(129, "[Phantasm]{Spell Card} Shikigami \"Channeling Dakiniten\"", "Shikigami \"Channeling Dakiniten\"", "", true, true),
    Tuple.Create(129, "[Phantasm]{Boss Appears} Yukari Appears", "Yukari Appears", "", true, true),
    Tuple.Create(130, "[Phantasm]{Nonspell} Yukari Nonspell 1", "Yukari Nonspell 1", "", true, true),
    Tuple.Create(130, "[Phantasm]{Spell Card} Barrier \"Curse of Dreams and Reality\"", "Barrier \"Curse of Dreams and Reality\"", "", true, true),
    Tuple.Create(131, "[Phantasm]{Nonspell} Yukari Nonspell 2", "Yukari Nonspell 2", "", true, true),
    Tuple.Create(131, "[Phantasm]{Spell Card} Barrier \"Balance of Motion and Stillness\"", "Barrier \"Balance of Motion and Stillness\"", "", true, true),
    Tuple.Create(132, "[Phantasm]{Nonspell} Yukari Nonspell 3", "Yukari Nonspell 3", "", true, true),
    Tuple.Create(132, "[Phantasm]{Spell Card} Barrier \"Mesh of Light and Darkness\"", "Barrier \"Mesh of Light and Darkness\"", "", true, true),
    Tuple.Create(133, "[Phantasm]{Nonspell} Yukari Nonspell 4", "Yukari Nonspell 4", "", true, true),
    Tuple.Create(133, "[Phantasm]{Spell Card} Evil Spirits \"Dreamland of Straight and Curve\"", "Evil Spirits \"Dreamland of Straight and Curve\"", "", true, true),
    Tuple.Create(134, "[Phantasm]{Nonspell} Yukari Nonspell 5", "Yukari Nonspell 5", "", true, true),
    Tuple.Create(134, "[Phantasm]{Spell Card} Evil Spirits \"Yukari Yakumo's Spiriting Away\"", "Evil Spirits \"Yukari Yakumo's Spiriting Away\"", "", true, true),
    Tuple.Create(135, "[Phantasm]{Nonspell} Yukari Nonspell 6", "Yukari Nonspell 6", "", true, true),
    Tuple.Create(135, "[Phantasm]{Spell Card} Evil Spirits \"Bewitching Butterfly Living in the Zen Temple\"", "Evil Spirits \"Bewitching Butterfly Living in the Zen Temple\"", "", true, true),
    Tuple.Create(136, "[Phantasm]{Nonspell} Yukari Nonspell 7", "Yukari Nonspell 7", "", true, true),
    Tuple.Create(136, "[Phantasm]{Spell Card} Sinister Spirits \"Double Black Death Butterfly\"", "Sinister Spirits \"Double Black Death Butterfly\"", "", true, true),
    Tuple.Create(137, "[Phantasm]{Nonspell} Yukari Nonspell 8", "Yukari Nonspell 8", "", true, true),
    Tuple.Create(137, "[Phantasm]{Spell Card} Shikigami \"Ran Yakumo\"", "Shikigami \"Ran Yakumo\"", "", true, true),
    Tuple.Create(138, "[Phantasm]{Spell Card} \"Boundary of Humans and Youkai\"", "Boundary of Humans and Youkai", "", true, true),
    Tuple.Create(139, "[Phantasm]{Spell Card} Barrier \"Boundary of Life and Death\"", "Barrier \"Boundary of Life and Death\"", "", true, true),
    Tuple.Create(140, "[Phantasm]{Spell Card} Yukari's Arcanum \"Danmaku Barrier\"", "Yukari's Arcanum \"Danmaku Barrier\"", "", true, true),
  };

  vars.original_splits = new Dictionary<string, int>();
  vars.splits = null;

  vars.long_prefix_re = new System.Text.RegularExpressions.Regex(@"^\[.*\]|(?<=^<Parent> )\[.*\](?=\[.*?\])");
  vars.short_prefix_re = new System.Text.RegularExpressions.Regex(@"\[.*?\]");
  foreach (var v in split_defs) {
    var val = v.Item1;
    var key = v.Item2;
    var label = v.Item3;
    var tooltip = v.Item4;
    var enabled = v.Item5;
    var visible = v.Item6;

    if (!visible)
      continue;

    var m = vars.long_prefix_re.Match(key);
    if (m.Success) {
      var prefix = m.Value;
      settings.CurrentDefaultParent = "<Parent> " + prefix;
    } else if (key.StartsWith("<Parent>")) {
      settings.CurrentDefaultParent = null;
    }

    settings.Add(key, enabled, label);
    if (tooltip != "")
      settings.SetToolTip(key, tooltip);

    // parent of nodes
    if (key.StartsWith("<Parent>"))
      continue;

    vars.original_splits.Add(key, val);
  }

  vars.getMemoryWatcherList = (Func<Process, MemoryWatcherList>)((proc) => {
    return new MemoryWatcherList {
      new MemoryWatcher<int>((IntPtr)0x575aa4) { Name = "in Play Screen?" },
      new MemoryWatcher<int>((IntPtr)0x575aa8) { Name = "Started?" },
      new MemoryWatcher<int>((IntPtr)0x575aa8) { Name = "in Title Screen?" },

      new MemoryWatcher<int>((IntPtr)0x62f648) { Name = "st_48" },
      new MemoryWatcher<int>((IntPtr)0x62f64c) { Name = "st_4c" },

      new MemoryWatcher<int>((IntPtr)0x62f85c) { Name = "Stage" },
      new MemoryWatcher<int>((IntPtr)0x62f858) { Name = "Frame Count" }, // for iGT

      new MemoryWatcher<int>((IntPtr)0x12fe098) { Name = "Boss Exists?" },
      new MemoryWatcher<int>((IntPtr)0x12fe0c8) { Name = "in Spell Card?" },
      new MemoryWatcher<int>((IntPtr)0x12fe0d8) { Name = "Spell Card No" },
    };
  });

  vars.timer_OnStart = (EventHandler)((s, e) => {
    // copy splits
    vars.splits = new Dictionary<string, int>(vars.original_splits);

    vars.already_playscreen = false;
    vars.duration_before_playscreen = TimeSpan.Zero;
  });
  timer.OnStart += vars.timer_OnStart;
}

init
{
  refreshRate = 60;

  vars.started = (Func<bool>) (() => {
    var res = (vars.w["Started?"].Old == 1 && vars.w["Started?"].Current == 2
               || vars.w["Started?"].Old == 2 && vars.w["Started?"].Current == 10);
    return res;
  });

  vars.interrupted = (Func<bool>) (() => {
    var res = (vars.w["Started?"].Old == 2 && vars.w["Started?"].Current == 1
               || vars.w["Started?"].Old == 2 && vars.w["Started?"].Current == 10);
    return res;
  });

  vars.playscreen_shown = (Func<bool>) (() => {
    var res = vars.w["in Play Screen?"].Old == 1 && vars.w["in Play Screen?"].Current == 2;
    return res;
  });
  
  vars.in_pause = (Func<bool>) (() => {
    return (vars.w["st_48"].Current & 0x04) != 0;
  });

  // vars.in_replay = (Func<bool>) (() => {
  //   return false;
  // });

  vars.stage_name = (Func<string>) (() => {
    int idx = vars.w["Stage"].Current;
    if (idx < 1 || idx > 8)
      return "";

    return vars.stage_name_table[idx];
  });

  vars.stage_matched = (Func<string, bool>) ((key) => {
    string pattern = "[" + vars.stage_name() + "]";
    // print(pattern);
    return key.Contains(pattern);
  });

  vars.in_spellcard = (Func<bool>) (() => {
    return vars.w["in Spell Card?"].Current != 0;
  });

  // もっと単純化したい
  vars.boss_appears = (Func<string, int, bool>) ((key, prev_scno) => {
    if (!(vars.w["Boss Exists?"].Old == 0 && vars.w["Boss Exists?"].Current != 0))
      return false;
    var m = vars.boss_appears_re.Match(key);
    // print(key);
    // print(m.Value);
    if (!m.Success)
      return false;

    string boss = m.Value;
    string stage = vars.stage_name();
    switch (boss) {
    case "Chen":
      return stage == "Extra" && prev_scno == 0;
    case "Ran":
      return stage == "Extra" && prev_scno == 117 || stage == "Phantasm" && prev_scno == 0;
    case "Yukari":
      return prev_scno == 129;
    default:
      return false;
    }
  });

  vars.spellcard_ended = (Func<int, bool>) ((scno) => {
    return (vars.w["in Spell Card?"].Old != 0
            && vars.w["Spell Card No"].Old == scno
            && (vars.w["in Spell Card?"].Current == 0 || vars.w["Spell Card No"].Current != scno));
  });

  vars.nonspell_ended = (Func<int, bool>) ((next_scno) => {
    return (vars.w["in Spell Card?"].Old == 0
            && vars.w["in Spell Card?"].Current != 0
            && vars.w["Spell Card No"].Current == next_scno);
  });

  vars.w = vars.getMemoryWatcherList(game);
  vars.w.UpdateAll(game);
}

update
{
  vars.w.UpdateAll(game);
}

start
{
  return vars.started();
}

reset
{
  return vars.interrupted();
}

split
{
  foreach (var kv in vars.splits) {
    var key = kv.Key;
    var val = kv.Value;
    if (!settings[key])
      continue;
    if (!vars.stage_matched(key))
      continue;

    var ok = false;
    if (key.Contains("{Boss Appears}")) {
      ok = vars.boss_appears(key, val);
    } else if (key.Contains("{Spell Card}")) {
      ok = vars.spellcard_ended(val);
    } else if (key.Contains("{Nonspell}")) {
      ok = vars.nonspell_ended(val);
    } else {
      print("[ASL] Unknown Split Key: " + key);
    }

    if (ok) {
      print("[ASL] Split: " + key);
      vars.splits.Remove(key);
      return true;
      return false;
    }
  }
}

isLoading {
}

gameTime {
  // 中央画面表示までの時間を加算
  if (!vars.already_playscreen) {
    vars.duration_before_playscreen = timer.CurrentTime.RealTime.Value;
    if (vars.playscreen_shown())
      vars.already_playscreen = true;
  }

  long igt_ticks = (long)vars.w["Frame Count"].Current * 10000000 / 60;
  return vars.duration_before_playscreen + TimeSpan.FromTicks(igt_ticks);
}

shutdown
{
  timer.OnStart -= vars.timer_OnStart;
}

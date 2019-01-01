// Please move both of your "scoreth095.dat" and "bestshot" directory to other directory before "Normal" Run.

state("th095", "ver 1.02a")
{
  int unknown : 0x0c4df4;
  int st2_offset : 0x0c4e70;
  int scenes_offset : 0x0c4e78;
}

// English Patched - https://en.touhouwiki.net/wiki/Shoot_the_Bullet/English_patch
state("th095e", "ver 1.02a with English Patch v1.1")
{
  int unknown : 0x0c4df4;
  int st2_offset : 0x0c4e70;
  int scenes_offset : 0x0c4e78;
}

startup
{
  vars.DEBUG = false;

  // All Scenes (except EN1): 85
  vars.scenes_number = 85;
  // Level 1-EX and EN1
  int[] tmp = { 6, 6, 8, 9, 8, 8, 8, 8, 8, 8, 8, 8, };
  vars.scenes = tmp;
  vars.clear_flags = new bool[121];

  vars.split_nr_delay = 5;
  vars.split_et_delay = 80;

  // vars.history_number = 3;
  vars.history_number = 20;


  vars.st2_offset = IntPtr.Zero;
  vars.scenes_offset = IntPtr.Zero;

  vars.split_counter = 0;

  // statistics
  vars.current_clear_count = 0;
  vars.old_clear_count = 0;
  vars.current_shot_count = 0;
  vars.old_shot_count = 0;
  vars.death_count = 0;

  // ticks, succeed
  vars.history = new Queue<Tuple<long, bool>>();

  vars.succeed = false;
  vars.total_attempt_count = 0;
  vars.total_success_count = 0;
  vars.history_success_count = 0;
  vars.recent_average_ticks = 0L;
  vars.current_combo = 0;
  vars.max_combo = 0;
  vars.start_ticks = 0L;

  // val, settingkey, label, tooltip, enabled, visible
  var split_defs = new List<Tuple<int, string, string, string, bool, bool>> {
    Tuple.Create(-1, "<Parent> [Normal Run]", "Normal Run", "If you uncheck this option, LiveSplit splits each time any scenes are cleared. (e.g. Kinkaku-ji 108 run)", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level 1]", "Level 1", "", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level 2]", "Level 2", "", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level 3]", "Level 3", "", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level 4]", "Level 4", "", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level 5]", "Level 5", "", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level 6]", "Level 6", "", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level 7]", "Level 7", "", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level 8]", "Level 8", "", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level 9]", "Level 9", "", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level 10]", "Level 10", "", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level EX]", "Level EX", "", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Level NE1]", "Level NE1", "Newspaper Extra 1", false, true),
    Tuple.Create(0, "[Normal Run][Level 1] 1-1", "1-1", "", false, true),
    Tuple.Create(1, "[Normal Run][Level 1] 1-2", "1-2", "", false, true),
    Tuple.Create(2, "[Normal Run][Level 1] 1-3", "1-3", "", false, true),
    Tuple.Create(3, "[Normal Run][Level 1] 1-4", "1-4", "", false, true),
    Tuple.Create(4, "[Normal Run][Level 1] 1-5", "1-5", "", false, true),
    Tuple.Create(5, "[Normal Run][Level 1] 1-6", "1-6", "", true, true),
    Tuple.Create(10, "[Normal Run][Level 2] 2-1", "2-1", "", false, true),
    Tuple.Create(11, "[Normal Run][Level 2] 2-2", "2-2", "", false, true),
    Tuple.Create(12, "[Normal Run][Level 2] 2-3", "2-3", "", false, true),
    Tuple.Create(13, "[Normal Run][Level 2] 2-4", "2-4", "", false, true),
    Tuple.Create(14, "[Normal Run][Level 2] 2-5", "2-5", "", false, true),
    Tuple.Create(15, "[Normal Run][Level 2] 2-6", "2-6", "", true, true),
    Tuple.Create(20, "[Normal Run][Level 3] 3-1", "3-1", "", false, true),
    Tuple.Create(21, "[Normal Run][Level 3] 3-2", "3-2", "", false, true),
    Tuple.Create(22, "[Normal Run][Level 3] 3-3", "3-3", "", false, true),
    Tuple.Create(23, "[Normal Run][Level 3] 3-4", "3-4", "", false, true),
    Tuple.Create(24, "[Normal Run][Level 3] 3-5", "3-5", "", false, true),
    Tuple.Create(25, "[Normal Run][Level 3] 3-6", "3-6", "", false, true),
    Tuple.Create(26, "[Normal Run][Level 3] 3-7", "3-7", "", false, true),
    Tuple.Create(27, "[Normal Run][Level 3] 3-8", "3-8", "", true, true),
    Tuple.Create(30, "[Normal Run][Level 4] 4-1", "4-1", "", false, true),
    Tuple.Create(31, "[Normal Run][Level 4] 4-2", "4-2", "", false, true),
    Tuple.Create(32, "[Normal Run][Level 4] 4-3", "4-3", "", false, true),
    Tuple.Create(33, "[Normal Run][Level 4] 4-4", "4-4", "", false, true),
    Tuple.Create(34, "[Normal Run][Level 4] 4-5", "4-5", "", false, true),
    Tuple.Create(35, "[Normal Run][Level 4] 4-6", "4-6", "", false, true),
    Tuple.Create(36, "[Normal Run][Level 4] 4-7", "4-7", "", false, true),
    Tuple.Create(37, "[Normal Run][Level 4] 4-8", "4-8", "", false, true),
    Tuple.Create(38, "[Normal Run][Level 4] 4-9", "4-9", "", true, true),
    Tuple.Create(40, "[Normal Run][Level 5] 5-1", "5-1", "", false, true),
    Tuple.Create(41, "[Normal Run][Level 5] 5-2", "5-2", "", false, true),
    Tuple.Create(42, "[Normal Run][Level 5] 5-3", "5-3", "", false, true),
    Tuple.Create(43, "[Normal Run][Level 5] 5-4", "5-4", "", false, true),
    Tuple.Create(44, "[Normal Run][Level 5] 5-5", "5-5", "", false, true),
    Tuple.Create(45, "[Normal Run][Level 5] 5-6", "5-6", "", false, true),
    Tuple.Create(46, "[Normal Run][Level 5] 5-7", "5-7", "", false, true),
    Tuple.Create(47, "[Normal Run][Level 5] 5-8", "5-8", "", true, true),
    Tuple.Create(50, "[Normal Run][Level 6] 6-1", "6-1", "", false, true),
    Tuple.Create(51, "[Normal Run][Level 6] 6-2", "6-2", "", false, true),
    Tuple.Create(52, "[Normal Run][Level 6] 6-3", "6-3", "", false, true),
    Tuple.Create(53, "[Normal Run][Level 6] 6-4", "6-4", "", false, true),
    Tuple.Create(54, "[Normal Run][Level 6] 6-5", "6-5", "", false, true),
    Tuple.Create(55, "[Normal Run][Level 6] 6-6", "6-6", "", false, true),
    Tuple.Create(56, "[Normal Run][Level 6] 6-7", "6-7", "", false, true),
    Tuple.Create(57, "[Normal Run][Level 6] 6-8", "6-8", "", true, true),
    Tuple.Create(60, "[Normal Run][Level 7] 7-1", "7-1", "", false, true),
    Tuple.Create(61, "[Normal Run][Level 7] 7-2", "7-2", "", false, true),
    Tuple.Create(62, "[Normal Run][Level 7] 7-3", "7-3", "", false, true),
    Tuple.Create(63, "[Normal Run][Level 7] 7-4", "7-4", "", false, true),
    Tuple.Create(64, "[Normal Run][Level 7] 7-5", "7-5", "", false, true),
    Tuple.Create(65, "[Normal Run][Level 7] 7-6", "7-6", "", false, true),
    Tuple.Create(66, "[Normal Run][Level 7] 7-7", "7-7", "", false, true),
    Tuple.Create(67, "[Normal Run][Level 7] 7-8", "7-8", "", true, true),
    Tuple.Create(70, "[Normal Run][Level 8] 8-1", "8-1", "", false, true),
    Tuple.Create(71, "[Normal Run][Level 8] 8-2", "8-2", "", false, true),
    Tuple.Create(72, "[Normal Run][Level 8] 8-3", "8-3", "", false, true),
    Tuple.Create(73, "[Normal Run][Level 8] 8-4", "8-4", "", false, true),
    Tuple.Create(74, "[Normal Run][Level 8] 8-5", "8-5", "", false, true),
    Tuple.Create(75, "[Normal Run][Level 8] 8-6", "8-6", "", false, true),
    Tuple.Create(76, "[Normal Run][Level 8] 8-7", "8-7", "", false, true),
    Tuple.Create(77, "[Normal Run][Level 8] 8-8", "8-8", "", true, true),
    Tuple.Create(80, "[Normal Run][Level 9] 9-1", "9-1", "", false, true),
    Tuple.Create(81, "[Normal Run][Level 9] 9-2", "9-2", "", false, true),
    Tuple.Create(82, "[Normal Run][Level 9] 9-3", "9-3", "", false, true),
    Tuple.Create(83, "[Normal Run][Level 9] 9-4", "9-4", "", false, true),
    Tuple.Create(84, "[Normal Run][Level 9] 9-5", "9-5", "", false, true),
    Tuple.Create(85, "[Normal Run][Level 9] 9-6", "9-6", "", false, true),
    Tuple.Create(86, "[Normal Run][Level 9] 9-7", "9-7", "", false, true),
    Tuple.Create(87, "[Normal Run][Level 9] 9-8", "9-8", "", true, true),
    Tuple.Create(90, "[Normal Run][Level 10] 10-1", "10-1", "", false, true),
    Tuple.Create(91, "[Normal Run][Level 10] 10-2", "10-2", "", false, true),
    Tuple.Create(92, "[Normal Run][Level 10] 10-3", "10-3", "", false, true),
    Tuple.Create(93, "[Normal Run][Level 10] 10-4", "10-4", "", false, true),
    Tuple.Create(94, "[Normal Run][Level 10] 10-5", "10-5", "", false, true),
    Tuple.Create(95, "[Normal Run][Level 10] 10-6", "10-6", "", false, true),
    Tuple.Create(96, "[Normal Run][Level 10] 10-7", "10-7", "", false, true),
    Tuple.Create(97, "[Normal Run][Level 10] 10-8", "10-8", "", true, true),
    Tuple.Create(100, "[Normal Run][Level EX] EX-1", "EX-1", "", false, true),
    Tuple.Create(101, "[Normal Run][Level EX] EX-2", "EX-2", "", false, true),
    Tuple.Create(102, "[Normal Run][Level EX] EX-3", "EX-3", "", false, true),
    Tuple.Create(103, "[Normal Run][Level EX] EX-4", "EX-4", "", false, true),
    Tuple.Create(104, "[Normal Run][Level EX] EX-5", "EX-5", "", false, true),
    Tuple.Create(105, "[Normal Run][Level EX] EX-6", "EX-6", "", false, true),
    Tuple.Create(106, "[Normal Run][Level EX] EX-7", "EX-7", "", false, true),
    Tuple.Create(107, "[Normal Run][Level EX] EX-8", "EX-8", "", true, true),
    Tuple.Create(110, "[Normal Run][Level NE1] NE1-1", "NE1-1", "", false, true),
    Tuple.Create(111, "[Normal Run][Level NE1] NE1-2", "NE1-2", "", false, true),
    Tuple.Create(112, "[Normal Run][Level NE1] NE1-3", "NE1-3", "", false, true),
    Tuple.Create(113, "[Normal Run][Level NE1] NE1-4", "NE1-4", "", false, true),
    Tuple.Create(114, "[Normal Run][Level NE1] NE1-5", "NE1-5", "", false, true),
    Tuple.Create(115, "[Normal Run][Level NE1] NE1-6", "NE1-6", "", false, true),
    Tuple.Create(116, "[Normal Run][Level NE1] NE1-7", "NE1-7", "", false, true),
    Tuple.Create(117, "[Normal Run][Level NE1] NE1-8", "NE1-8", "", false, true),
  };

  settings.Add("Show Statistics", false, "Show Statistics");
  settings.SetToolTip("Show Statistics", "Normal Run: Clear, Shot and Death Count in a Text Component.\nnot Normal Run: Success Rate, Average Time and Combo in 3 Text Components.");

  vars.splits = new Dictionary<string, int>();

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

    vars.splits.Add(key, val);
  }

  vars.update_counts = (Func<Process, bool>)((proc) => {
    vars.old_shot_count = vars.current_shot_count;
    vars.old_clear_count = vars.current_clear_count;

    var total_clear = 0;
    var total_shot = 0;
    for (int i = 0; i < vars.scenes.Length; ++i) {
      for (int j = 0; j < vars.scenes[i]; ++j) {
        var idx = i * 10 + j;
        // clear
        var flg = proc.ReadValue<int>((IntPtr)vars.scenes_offset + 0x60 * idx + 0x04b0) != 0;
        vars.clear_flags[idx] = flg;
        if (flg)
          ++total_clear;
        // shot
        var shot = proc.ReadValue<int>((IntPtr)vars.scenes_offset + 0x60 * idx + 0x0504);
        total_shot += shot;
      }
    }
    vars.current_clear_count = total_clear;
    vars.current_shot_count = total_shot;

    // changed?
    return (vars.current_clear_count != vars.old_clear_count
            || vars.current_shot_count != vars.old_shot_count);
  });

  vars.is_cleared = (Func<Process, int, bool>)((proc, idx) => {
    // return proc.ReadValue<int>((IntPtr)vars.scenes_offset + 0x60 * idx + 0x04b0) != 0;
    return vars.clear_flags[idx];
  });

  vars.tcss = new List<System.Windows.Forms.UserControl>();
  foreach (LiveSplit.UI.Components.IComponent component in timer.Layout.Components) {
    if (component.GetType().Name == "TextComponent") {
      vars.tc = component;
      vars.tcss.Add(vars.tc.Settings);
      print("[ASL] Found text component at " + component);
    }
  }
  print("[ASL] *Found " + vars.tcss.Count.ToString() + " text component(s)*");
}

init
{
  refreshRate = 60;

  vars.update_statistics = (Func<Process, bool>)((proc) => {
    if (!settings["Show Statistics"]) {
      return false;
    }

    if (settings["<Parent> [Normal Run]"]) {
      if (vars.tcss.Count > 0) {
        // left: Clear Count
        vars.tcss[0].Text1 = string.Format("Clear: {0:d}/{1:d}", vars.current_clear_count, vars.scenes_number);
        // right: Shot (Death) Count
        vars.tcss[0].Text2 = string.Format("Shot (Death): {0:d} ({1:d})", vars.current_shot_count, vars.death_count);
      }
    } else {
      // 1st line: Success Rate
      if (vars.tcss.Count > 0) {
        vars.tcss[0].Text1 = "Success Rate";

        var per = (vars.total_attempt_count != 0
                   ? (double)vars.total_success_count / (double)vars.total_attempt_count * 100
                   : 0.0);
        vars.tcss[0].Text2 = string.Format("{0:f1}% ({1:d}/{2:d})", per, vars.total_success_count, vars.total_attempt_count);
      }
      // 2nd line: Average of Recent N
      if (vars.tcss.Count > 1) {
        vars.tcss[1].Text1 = string.Format("Ave of Recent {0:d}", vars.history_number);

        long hour = TimeSpan.FromHours(1).Ticks;
        double spd = (vars.recent_average_ticks != 0
                      ? (double)hour / (double)vars.recent_average_ticks
                      : 0.0);
        vars.tcss[1].Text2 = string.Format("{0:m\\:ss\\.f} ({1:f1}/h)", TimeSpan.FromTicks(vars.recent_average_ticks), spd);
      }
      // 3rd line: Combo
      if (vars.tcss.Count > 2) {
        vars.tcss[2].Text1 = "Combo";
        vars.tcss[2].Text2 = string.Format("{0:d} (max: {1:d})", vars.current_combo, vars.max_combo);
      }
    }

    return true;
  });

  vars.scenes_offset = (IntPtr)current.scenes_offset;
  vars.st2 = new MemoryWatcher<int>((IntPtr)current.st2_offset);

  vars.update_counts(game);
  vars.update_statistics(game);
}

update
{
  if (current.scenes_offset != old.scenes_offset) {
    vars.scenes_offset = (IntPtr)current.scenes_offset;
  }
  if (current.st2_offset != old.st2_offset) {
    vars.st2 = new MemoryWatcher<int>((IntPtr)current.st2_offset);
  }
  vars.st2.Update(game);

  var changed = vars.update_counts(game);
  // Normal Run: update if any counts are changed.
  if (settings["<Parent> [Normal Run]"] && changed) {
    vars.update_statistics(game);
  }
}

start
{
  // not Normal Run || 1-1 is not cleared
  var not_1_1_cleared = game.ReadValue<int>((IntPtr)vars.scenes_offset + 0x60 * 0 + 0x04b0) == 0;
  var ok = ((old.unknown == 0 && current.unknown != 0)
            && (!settings["<Parent> [Normal Run]"] || not_1_1_cleared));

  if (ok) {
    // statistics
    vars.current_clear_count = 0;
    vars.old_clear_count = 0;
    vars.current_shot_count = 0;
    vars.old_shot_count = 0;
    vars.death_count = 0;

    vars.succeed = false;
    vars.total_attempt_count = 0;
    vars.total_success_count = 0;
    vars.history_success_count = 0;
    vars.recent_average_ticks = 0;
    vars.current_combo = 0;
    vars.max_combo = 0;

    vars.history.Clear();
    // sentinel
    vars.start_ticks = Stopwatch.GetTimestamp() * 10000000 / Stopwatch.Frequency;
    vars.history.Enqueue(Tuple.Create(vars.start_ticks, false));

    vars.update_counts(game);
    vars.update_statistics(game);
  }
  return ok;
}

split
{
  if (vars.split_counter > 0) {
    if (--vars.split_counter != 0) {
      return false;
    }

    if (!settings["Show Statistics"]) {
      return vars.succeed;
    }

    if (settings["<Parent> [Normal Run]"]) { // Normal Run
      if (!vars.succeed) {
        ++vars.death_count;
      }
    } else { // not Normal Run
      var v = vars.history.Peek();
      var history_top_ticks = v.Item1;
      var history_top_succeed = v.Item2;

      if (history_top_succeed)
        --vars.history_success_count;

      ++vars.total_attempt_count;
      if (vars.succeed) {
        ++vars.total_success_count;
        ++vars.history_success_count;

        ++vars.current_combo;
        vars.max_combo = Math.Max(vars.max_combo, vars.current_combo);
      } else {
        vars.current_combo = 0;
      }

      var current_ticks = Stopwatch.GetTimestamp() * 10000000 / Stopwatch.Frequency;
      var elapsed_ticks = current_ticks - history_top_ticks;
      vars.recent_average_ticks = (vars.history_success_count != 0
                                   ? elapsed_ticks / vars.history_success_count
                                   : 0L);

      if (vars.history.Count == vars.history_number) {
        vars.history.Dequeue();
      }
      var new_elem = Tuple.Create(current_ticks, vars.succeed);
      vars.history.Enqueue(new_elem);

      if (vars.DEBUG) {
        var i = 0;
        foreach (var vv in vars.history) {
          var t = TimeSpan.FromTicks(vv.Item1 - vars.start_ticks);
          print(string.Format("{0:d}: {1:hh\\:mm\\:ss\\.f} {2:g}", i, t, vv.Item2));
          ++i;
        }
      }
    }
    vars.update_statistics(game);

    return vars.succeed;
  }

  // Dead
  if (vars.st2.Old == 1 && vars.st2.Current == 2) {
    vars.split_counter = 1;
    vars.succeed = false;
    return false;
  }

  // Success
  if (settings["<Parent> [Normal Run]"]) {
    foreach (var kv in vars.splits) {
      var key = kv.Key;
      var val = kv.Value;
      if (!settings[key])
        continue;

      var ok = false;
      if (key.StartsWith("[Normal Run]")) {
        if (ok = vars.is_cleared(game, val)) {
          vars.split_counter = vars.split_nr_delay;
          vars.succeed = true;
        }
      } else {
        print("[ASL] Unknown Split Key: " + key);
      }

      if (ok) {
        print("[ASL] Split: " + key);
        vars.splits.Remove(key);
        return false;
      }
    }
  } else {
    if (vars.st2.Old == 1 && vars.st2.Current == 3) {
      vars.split_counter = vars.split_et_delay;
      vars.succeed = true;
      return false;
    }
  }
}

reset
{
}

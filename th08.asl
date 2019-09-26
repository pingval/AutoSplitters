state("th08", "ver 1.00d")
{
  // int started : 0x124d348;
  // int st_b0 : 0x124d0b0;
  // int st_b4 : 0x124d0b4;
  // int st_b8 : 0x124d0b8;
  // int dead : 0x13d6ed8;
}

startup
{
  vars.DEBUG = false;

  vars.spells_number = 222;
  vars.spell_indexes = Enumerable.Range(0, 222).ToArray();

  // All Last Words
  vars.spells_number_lw = 17;
  vars.spell_indexes_lw = Enumerable.Range(205, 17).ToArray();

  vars.clear_flags = Enumerable.Repeat<bool>(false, 256).ToArray();

  vars.split_delay = 1;
  vars.split_counter = 0;

  // vars.history_number = 3;
  // vars.history_number = 20;

  // statistics
  vars.update = false;
  vars.death_count = 0;

  // // RealTime, succeed
  // vars.history = new Queue<Tuple<TimeSpan, bool>>();

  // vars.succeed = false;
  // vars.total_attempt_count = 0;
  // vars.total_success_count = 0;
  // vars.history_success_count = 0;
  // vars.recent_average_timespan = TimeSpan.Zero;
  // vars.current_combo = 0;
  // vars.max_combo = 0;

  // val, settingkey, label, tooltip, enabled, visible
  var split_defs = new List<Tuple<int, string, string, string, bool, bool>> {
  };

  settings.Add("Auto Start", true, "Auto Start");
  // settings.SetToolTip("Auto Start", "Start timing on SRC rules");
  settings.Add("All Last Words Run", true, "All Last Words Run");
  settings.SetToolTip("All Last Words Run", "17 Spell Cards from No.206 to No.222.");
  settings.Add("Show Statistics", true, "Show Statistics");
  settings.SetToolTip("Show Statistics", "Clear and Death Count in a Text Component.");

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

  vars.tcss = new List<System.Windows.Forms.UserControl>();
  foreach (LiveSplit.UI.Components.IComponent component in timer.Layout.Components) {
    if (component.GetType().Name == "TextComponent") {
      vars.tc = component;
      vars.tcss.Add(vars.tc.Settings);
      print("[ASL] Found text component at " + component);
    }
  }
  print("[ASL] *Found " + vars.tcss.Count.ToString() + " text component(s)*");

  vars.getMemoryWatcherList = (Func<Process, MemoryWatcherList>)((proc) => {
    return new MemoryWatcherList {
      new MemoryWatcher<int>((IntPtr)0x164d348) { Name = "Starting?" },
      new MemoryWatcher<int>((IntPtr)0x164d0b0) { Name = "st_b0" },
      new MemoryWatcher<int>((IntPtr)0x164d0b4) { Name = "st_b4" },
      new MemoryWatcher<int>((IntPtr)0x164d0b8) { Name = "st_b8" },
      new MemoryWatcher<int>((IntPtr)0x17d6ed8) { Name = "SP Failed?" },
    };
  });
}

init
{
  refreshRate = 60;

  vars.starting = (Func<bool>) (() => {
    var res = !vars.in_replay() && vars.w["Starting?"].Current != 0;
    if (settings["All Last Words Run"]) {
      res = res && vars.in_spell_practice() && vars.current_spellcard() == 205;
    }
    return res;
  });

  vars.in_pause = (Func<bool>) (() => {
    return (vars.w["st_b8"].Current & 0x20000) != 0;
  });

  vars.in_replay = (Func<bool>) (() => {
    return (vars.w["st_b4"].Current & 0x08) != 0;
  });

  vars.current_spellcard = (Func<int>) (() => {
    return vars.w["st_b8"].Current & 0xff;
  });

  vars.in_spell_practice = (Func<bool>) (() => {
    return vars.current_spellcard() != 0xff;
  });

  vars.dying = (Func<bool>) (() => {
    // return (old.dead & 0x04) == 0 && (current.dead & 0x04) != 0;
    return (vars.w["SP Failed?"].Old & 0x04) == 0 && (vars.w["SP Failed?"].Current & 0x04) != 0;
  });

  vars.sp_cleared = (Func<bool>) (() => {
    var res = (vars.w["st_b8"].Current & 0x1000000) != 0 && vars.w["st_b4"].Changed && vars.w["st_b4"].Current == 0x0003c101;
    return res;
  });

  vars.set_clear_flag = (Func<int, bool>)((idx) => {
    var old_flag = vars.clear_flags[idx];
    vars.clear_flags[idx] = true;
    // already cleared
    if (old_flag) {
      return false;
    }

    var indexes = vars.spell_indexes;
    if (settings["All Last Words Run"]) {
      indexes = vars.spell_indexes_lw;
    }
    // contain?
    return Array.IndexOf(indexes, idx) != -1;
    // return Array.BinarySearch(indexes, idx) != -1;
  });

  vars.count_cleared_spells = (Func<int>)(() => {
    var indexes = vars.spell_indexes;
    if (settings["All Last Words Run"]) {
      indexes = vars.spell_indexes_lw;
    }

    var count = 0;
    foreach (int idx in indexes) {
      if (vars.clear_flags[idx])
        ++count;
    }
    return count;
  });

  vars.update_statistics = (Func<Process, bool>)((proc) => {
    if (!settings["Show Statistics"]) {
      return false;
    }

    if (true) {
      if (vars.tcss.Count > 0) {
        // left: Clear Count
        var spells_number = vars.spells_number;
        if (settings["All Last Words Run"]) {
          spells_number = vars.spells_number_lw;
        }

        var clear_count = vars.count_cleared_spells();
        vars.tcss[0].Text1 = string.Format("Clear: {0:d}/{1:d}", clear_count, spells_number);
        // right: Death Count
        vars.tcss[0].Text2 = string.Format("Death: {0:d}", vars.death_count);
      }
    } else {
    }

    return true;
  });
  vars.w = vars.getMemoryWatcherList(game);
  vars.w.UpdateAll(game);

  vars.update_statistics(game);
}

update
{
  if (vars.update) {
    vars.update_statistics(game);
    vars.update = false;
  }
  vars.w.UpdateAll(game);
}

start
{
  var ok = vars.starting();

  if (ok) {
    // copy splits
    vars.splits = new Dictionary<string, int>(vars.original_splits);

    // statistics
    vars.death_count = 0;
    vars.clear_flags = Enumerable.Repeat<bool>(false, 256).ToArray();

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

    if (!vars.succeed) {
      ++vars.death_count;
      vars.update = true;
    }

    return vars.succeed;
  }

  // Dead
  if (vars.dying()) {
    vars.split_counter = 1;
    vars.succeed = false;
    return false;
  }

  // Success
  if (true) {
    if (vars.sp_cleared()) {
      if (vars.DEBUG) {
        print("b0: " + vars.w["st_b0"].Current.ToString("X"));
        print("b4: " + vars.w["st_b4"].Old.ToString("X") + " => " + vars.w["st_b4"].Current.ToString("X"));
        print("b8: " + vars.w["st_b8"].Current.ToString("X"));
      }

      if (vars.set_clear_flag(vars.current_spellcard())) {
        vars.update = true;
        vars.succeed = true;
        vars.split_counter = vars.split_delay;
      }

      return false;
    }
  } else {
    foreach (var kv in vars.splits) {
      var key = kv.Key;
      var val = kv.Value;
      if (!settings[key])
        continue;

      var ok = false;
      if (key.StartsWith("[Normal Run]")) {
        if (ok = vars.sp_cleared(game, val)) {
          vars.split_counter = vars.split_delay;
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
  }
}

reset
{
}

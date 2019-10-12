state("th08", "ver 1.00d")
{
}

startup
{
  vars.DEBUG = false;

  // All Spell Cards
  vars.spellcards_number = 222;
  vars.spellcard_indexes = Enumerable.Range(0, 222).ToArray();

  // All Last Words
  vars.spellcards_number_lw = 17;
  vars.spellcard_indexes_lw = Enumerable.Range(205, 17).ToArray();

  // Extra Stage
  vars.spellcards_number_ex = 14;
  vars.spellcard_indexes_ex = Enumerable.Range(191, 14).ToArray();

  vars.clear_flags = Enumerable.Repeat<bool>(false, 256).ToArray();

  vars.split_delay = 1;
  vars.split_counter = 0;

  // vars.history_number = 3;
  // vars.history_number = 20;

  // statistics
  vars.update = false;
  vars.death_count = 0;
  // vars.bomb_count = 0;
  // vars.spellcard_count = 0;

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
    Tuple.Create(-1, "<Parent> [Extra]", "Extra", "If you uncheck this option, LiveSplit splits each time Spell Cards are cleared in Spell Practice. (e.g. All Last Words run)", true, true),
    Tuple.Create(0, "[Extra] Keine Appears", "Keine Appears", "", true, true),
    Tuple.Create(191, "[Extra] Past \"Old History of an Untrodden Land -Old History-\"", "Past \"Old History of an Untrodden Land -Old History-\"", "", true, true),
    Tuple.Create(192, "[Extra] Reincarnation \"Ichijou Returning Bridge\"", "Reincarnation \"Ichijou Returning Bridge\"", "", true, true),
    Tuple.Create(193, "[Extra] Future \"New History of Fantasy -Next History-\"", "Future \"New History of Fantasy -Next History-\"", "", true, true),
    Tuple.Create(193, "[Extra] Mokou Appears", "Mokou Appears", "", true, true),
    Tuple.Create(194, "[Extra] Limiting Edict \"Curse of Tsuki-no-Iwakasa\"", "Limiting Edict \"Curse of Tsuki-no-Iwakasa\"", "", true, true),
    Tuple.Create(195, "[Extra] Undying \"Fire Bird -Feng?Wing Ascension-\"", "Undying \"Fire Bird -Feng?Wing Ascension-\"", "", true, true),
    Tuple.Create(196, "[Extra] Fujiwara \"Wounds of Metsuzai Temple\"", "Fujiwara \"Wounds of Metsuzai Temple\"", "", true, true),
    Tuple.Create(197, "[Extra] Undying \"Xu Fu's Dimension\"", "Undying \"Xu Fu's Dimension\"", "", true, true),
    Tuple.Create(198, "[Extra] Expiation \"Honest Man's Death\"", "Expiation \"Honest Man's Death\"", "", true, true),
    Tuple.Create(199, "[Extra] Hollow Being \"Wu\"", "Hollow Being \"Wu\"", "", true, true),
    Tuple.Create(200, "[Extra] Inextinguishable \"Phoenix's Tail\"", "Inextinguishable \"Phoenix's Tail\"", "", true, true),
    Tuple.Create(201, "[Extra] Hourai \"South Wind, Clear Sky -Fujiyama Volcano-\"", "Hourai \"South Wind, Clear Sky -Fujiyama Volcano-\"", "", true, true),
    Tuple.Create(202, "[Extra] \"Possessed by Phoenix\"", "\"Possessed by Phoenix\"", "", true, true),
    Tuple.Create(203, "[Extra] \"Hourai Doll\"", "\"Hourai Doll\"", "", false, true),
    Tuple.Create(204, "[Extra] \"Imperishable Shooting\"", "\"Imperishable Shooting\"", "", false, true),
    Tuple.Create(0, "[Extra] Stage Clear", "Stage Clear", "", true, true),
  };

  settings.Add("Auto Start", true, "Auto Start");
  settings.SetToolTip("Auto Start", "Start timing on SRC rules");
  settings.Add("Show Statistics", true, "Show Statistics");
  settings.SetToolTip("Show Statistics", "Clear and Death Count in a Text Component.");
  settings.Add("All Last Words Run", false, "All Last Words Run");
  settings.SetToolTip("All Last Words Run", "17 Spell Cards from No.206 to No.222.");

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
      new MemoryWatcher<int>((IntPtr)0x164d348) { Name = "Started?" },

      new MemoryWatcher<int>((IntPtr)0x160f458) { Name = "Boss Appeared?" },
      new MemoryWatcher<int>((IntPtr)0x4ea674) { Name = "in Spell Card?" },
      new MemoryWatcher<int>((IntPtr)0x4ea678) { Name = "Spell Card No" },

      new MemoryWatcher<int>((IntPtr)0x164cfa4) { Name = "Death Count" },
      new MemoryWatcher<int>((IntPtr)0x164cfa8) { Name = "Bomb Count" },
      new MemoryWatcher<int>((IntPtr)0x160f510) { Name = "Spell Card Count Base" },

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

  vars.started = (Func<bool>) (() => {
    var res = !vars.in_replay() && vars.w["Started?"].Old == 0 && vars.w["Started?"].Current != 0;
    if (settings["All Last Words Run"]) {
      res = res && vars.in_spell_practice() && vars.get_current_spellcard() == 205;
    } else {
      res = res && !vars.in_spell_practice();
    }
    return res;
  });

  vars.interrupted = (Func<bool>) (() => {
    if (settings["All Last Words Run"]) {
      return false;
    }
    var res = !vars.in_replay() && vars.w["Started?"].Old != 0 && vars.w["Started?"].Current == 0;
    return res;
  });

  vars.in_pause = (Func<bool>) (() => {
    return (vars.w["st_b8"].Current & 0x20000) != 0;
  });

  vars.in_replay = (Func<bool>) (() => {
    if (vars.DEBUG) {
      return false;
    } else {
      return (vars.w["st_b4"].Current & 0x08) != 0;
    }
  });

  vars.in_spell_practice = (Func<bool>) (() => {
    return (vars.w["st_b8"].Current & 0xff) != 0xff;
  });

  vars.get_current_spellcard = (Func<int>) (() => {
    if (vars.in_spell_practice())
      return vars.w["st_b8"].Current & 0xff;
    else
      return vars.w["Spell Card No"].Current;
  });

  vars.sp_dead = (Func<bool>) (() => {
    return (vars.w["SP Failed?"].Old & 0x04) == 0 && (vars.w["SP Failed?"].Current & 0x04) != 0;
  });

  vars.sp_cleared = (Func<bool>) (() => {
    var res = (vars.w["st_b8"].Current & 0x1000000) != 0 && vars.w["st_b4"].Changed && vars.w["st_b4"].Current == 0x0003c101;
    return res;
  });

  vars.boss_appeared = (Func<bool>) (() => {
    return vars.w["Boss Appeared?"].Old == 0 && vars.w["Boss Appeared?"].Current != 0;
  });

  // true: spell card no. false: -1
  vars.spellcard_ended = (Func<int>) (() => {
    if (vars.w["in Spell Card?"].Old != 0 && vars.w["in Spell Card?"].Current == 0) {
      return vars.get_current_spellcard();
    } else {
      return -1;
    }
  });

  vars.set_clear_flag = (Func<int, bool>)((idx) => {
    var old_flag = vars.clear_flags[idx];
    vars.clear_flags[idx] = true;
    // already cleared
    if (old_flag) {
      return false;
    }

    var indexes = vars.spellcard_indexes;
    if (settings["All Last Words Run"]) {
      indexes = vars.spellcard_indexes_lw;
    }
    // contain?
    return Array.IndexOf(indexes, idx) != -1;
    // return Array.BinarySearch(indexes, idx) != -1;
  });

  vars.get_death_count = (Func<int>)(() => {
    if (settings["All Last Words Run"]) {
      return vars.death_count;
    } else {
      return vars.w["Death Count"].Current;
    }
  });

  vars.get_bomb_count = (Func<int>)(() => {
    return vars.w["Bomb Count"].Current;
  });

  vars.get_spellcard_count = (Func<int>)(() => {
    if (!settings["All Last Words Run"]) {
      return game.ReadValue<int>((IntPtr)vars.w["Spell Card Count Base"].Current + 0x1c);
    }

    var indexes = vars.spellcard_indexes;
    if (settings["All Last Words Run"]) {
      indexes = vars.spellcard_indexes_lw;
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

    if (vars.tcss.Count > 0) {
      // left: Spell Card Count
      var spellcards_number = vars.spellcards_number;
      if (settings["All Last Words Run"]) {
        spellcards_number = vars.spellcards_number_lw;
      } else if (settings["<Parent> [Extra]"]) {
        spellcards_number = vars.spellcards_number_ex;
      }
      var spellcard_count = vars.get_spellcard_count();
      vars.tcss[0].Text1 = string.Format("Spell Card: {0:d}/{1:d}", spellcard_count, spellcards_number);
  
      // right: Death Count
      vars.tcss[0].Text2 = string.Format("Death: {0:d}", vars.get_death_count());
    }

    return true;
  });
  vars.w = vars.getMemoryWatcherList(game);
  vars.w.UpdateAll(game);

  vars.update_statistics(game);
}

update
{
  vars.w.UpdateAll(game);

  if (!settings["All Last Words Run"]) {
    vars.update |= vars.w["Death Count"].Changed || vars.w["Bomb Count"].Changed;
  }

  if (vars.update) {
    vars.update_statistics(game);
    vars.update = false;
  }
}

start
{
  var ok = vars.started();

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

  if (settings["All Last Words Run"]) {
    // Dead
    if (vars.sp_dead()) {
      vars.split_counter = 1;
      vars.succeed = false;
      return false;
    }

    // Success
    if (vars.sp_cleared()) {
      if (vars.DEBUG) {
        print("b0: " + vars.w["st_b0"].Current.ToString("X"));
        print("b4: " + vars.w["st_b4"].Old.ToString("X") + " => " + vars.w["st_b4"].Current.ToString("X"));
        print("b8: " + vars.w["st_b8"].Current.ToString("X"));
      }

      if (vars.set_clear_flag(vars.get_current_spellcard())) {
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
      if (key.EndsWith("Appears")) {
        if (key.EndsWith("Keine Appears")) {
          ok = vars.boss_appeared() && vars.get_current_spellcard() == 0;
        } else if (key.EndsWith("Mokou Appears")) {
          ok = vars.boss_appeared() && vars.get_current_spellcard() == 193;
        }
      } else if (key.EndsWith("Stage Clear")) {
        var no = vars.spellcard_ended();
        if (vars.get_spellcard_count() < 7) {
          ok = no == 203;
        } else {
          ok = no == 204;
        }
      } else { // Spell Card ends
        var no = vars.spellcard_ended();
        ok = no != -1 && no == val;
      }

      if (ok) {
        vars.split_counter = vars.split_delay;
        vars.succeed = true;
        vars.update = true;

        print("[ASL] Split: " + key);
        vars.splits.Remove(key);
        return false;
      }
    }
  }
}

reset
{
  return vars.interrupted();
}

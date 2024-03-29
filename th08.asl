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

  vars.split_spok_delay = 1;
  vars.split_delay = 1;
  vars.split_counter = 0;

  // vars.history_number = 3;
  vars.history_number = 20;

  // statistics
  vars.update = false;
  vars.succeed = false;
  vars.death_count = 0;
  vars.bomb_count = 0;
  vars.spellcard_count = 0;
  vars.sp_attempting = false;

  // RealTime, succeed
  vars.history = new Queue<Tuple<TimeSpan, bool>>();

  vars.total_attempt_count = 0;
  vars.total_success_count = 0;
  vars.history_success_count = 0;
  vars.recent_average_timespan = TimeSpan.Zero;
  vars.current_combo = 0;
  vars.max_combo = 0;

  // val, settingkey, label, tooltip, enabled, visible
  var split_defs = new List<Tuple<int, string, string, string, bool, bool>> {
    Tuple.Create(-1, "Show Statistics", "Show Statistics", "Clear and Death Count in a Text Component.", true, true),
    Tuple.Create(-1, "Spell Practice Run", "Spell Practice Run", "Split each time Spell Cards are cleared in Spell Practice.", false, true),
    Tuple.Create(-1, "All Last Words Run", "All Last Words Run", "17 Spell Cards from No.206 to No.222.", false, true),
    Tuple.Create(-1, "Split on Menu in Spell Practice", "Split on Menu in Spell Practice", "", false, true),
    Tuple.Create(-1, "<Parent> [Extra]", "Extra", "If you uncheck this option, LiveSplit splits each time Spell Cards are cleared in Spell Practice. (e.g. All Last Words run)", true, true),
    Tuple.Create(0, "[Extra]{Boss Appears} Keine Appears", "Keine Appears", "", true, true),
    Tuple.Create(191, "[Extra]{Spell Card} Past \"Old History of an Untrodden Land -Old History-\"", "Past \"Old History of an Untrodden Land -Old History-\"", "", true, true),
    Tuple.Create(192, "[Extra]{Spell Card} Reincarnation \"Ichijou Returning Bridge\"", "Reincarnation \"Ichijou Returning Bridge\"", "", true, true),
    Tuple.Create(193, "[Extra]{Spell Card} Future \"New History of Fantasy -Next History-\"", "Future \"New History of Fantasy -Next History-\"", "", true, true),
    Tuple.Create(0, "[Extra]{Boss Appears} Mokou Appears", "Mokou Appears", "", true, true),
    Tuple.Create(194, "[Extra]{Nonspell} Mokou Nonspell 1", "Mokou Nonspell 1", "", true, true),
    Tuple.Create(194, "[Extra]{Spell Card} Limiting Edict \"Curse of Tsuki-no-Iwakasa\"", "Limiting Edict \"Curse of Tsuki-no-Iwakasa\"", "", true, true),
    Tuple.Create(195, "[Extra]{Nonspell} Mokou Nonspell 2", "Mokou Nonspell 2", "", true, true),
    Tuple.Create(195, "[Extra]{Spell Card} Undying \"Fire Bird -Feng?Wing Ascension-\"", "Undying \"Fire Bird -Feng?Wing Ascension-\"", "", true, true),
    Tuple.Create(196, "[Extra]{Nonspell} Mokou Nonspell 3", "Mokou Nonspell 3", "", true, true),
    Tuple.Create(196, "[Extra]{Spell Card} Fujiwara \"Wounds of Metsuzai Temple\"", "Fujiwara \"Wounds of Metsuzai Temple\"", "", true, true),
    Tuple.Create(197, "[Extra]{Nonspell} Mokou Nonspell 4", "Mokou Nonspell 4", "", true, true),
    Tuple.Create(197, "[Extra]{Spell Card} Undying \"Xu Fu's Dimension\"", "Undying \"Xu Fu's Dimension\"", "", true, true),
    Tuple.Create(198, "[Extra]{Nonspell} Mokou Nonspell 5", "Mokou Nonspell 5", "", true, true),
    Tuple.Create(198, "[Extra]{Spell Card} Expiation \"Honest Man's Death\"", "Expiation \"Honest Man's Death\"", "", true, true),
    Tuple.Create(199, "[Extra]{Nonspell} Mokou Nonspell 6", "Mokou Nonspell 6", "", true, true),
    Tuple.Create(199, "[Extra]{Spell Card} Hollow Being \"Wu\"", "Hollow Being \"Wu\"", "", true, true),
    Tuple.Create(200, "[Extra]{Nonspell} Mokou Nonspell 7", "Mokou Nonspell 7", "", true, true),
    Tuple.Create(200, "[Extra]{Spell Card} Inextinguishable \"Phoenix's Tail\"", "Inextinguishable \"Phoenix's Tail\"", "", true, true),
    Tuple.Create(201, "[Extra]{Nonspell} Mokou Nonspell 8", "Mokou Nonspell 8", "", true, true),
    Tuple.Create(201, "[Extra]{Spell Card} Hourai \"South Wind, Clear Sky -Fujiyama Volcano-\"", "Hourai \"South Wind, Clear Sky -Fujiyama Volcano-\"", "", true, true),
    Tuple.Create(202, "[Extra]{Spell Card} \"Possessed by Phoenix\"", "\"Possessed by Phoenix\"", "", true, true),
    Tuple.Create(203, "[Extra]{Spell Card} \"Hourai Doll\"", "\"Hourai Doll\"", "", false, true),
    Tuple.Create(204, "[Extra]{Spell Card} \"Imperishable Shooting\"", "\"Imperishable Shooting\"", "", false, true),
    Tuple.Create(0, "[Extra] Stage Clear", "Stage Clear", "", true, true),
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

      new MemoryWatcher<int>((IntPtr)0x160f458) { Name = "Boss Exists?" },
      new MemoryWatcher<int>((IntPtr)0x4ea634) { Name = "SP Gone to Title?" },
      new MemoryWatcher<int>((IntPtr)0x4ea674) { Name = "in Spell Card?" },
      new MemoryWatcher<int>((IntPtr)0x4ea678) { Name = "Spell Card No" },
      new MemoryWatcher<int>((IntPtr)0x4ea768) { Name = "SP Cleared?" },
      new MemoryWatcher<int>((IntPtr)0x4ea76c) { Name = "Spell Card Bonus" },

      new MemoryWatcher<int>((IntPtr)0x164cfa4) { Name = "Death Count" },
      new MemoryWatcher<int>((IntPtr)0x164cfa8) { Name = "Bomb Count" },
      new MemoryWatcher<int>((IntPtr)0x160f510) { Name = "Spell Card Count Base" },

      new MemoryWatcher<int>((IntPtr)0x164d0b0) { Name = "st_b0" },
      new MemoryWatcher<int>((IntPtr)0x164d0b4) { Name = "st_b4" },
      new MemoryWatcher<int>((IntPtr)0x164d0b8) { Name = "st_b8" },
    };
  });

  vars.timer_OnStart = (EventHandler)((s, e) => {
    // copy splits
    vars.splits = new Dictionary<string, int>(vars.original_splits);

    // statistics
    vars.death_count = 0;
    vars.clear_flags = Enumerable.Repeat<bool>(false, 256).ToArray();

    vars.succeed = false;
    vars.total_attempt_count = 0;
    vars.total_success_count = 0;
    vars.history_success_count = 0;
    vars.recent_average_timespan = TimeSpan.Zero;
    vars.current_combo = 0;
    vars.max_combo = 0;

    vars.history.Clear();
    // sentinel
    vars.history.Enqueue(Tuple.Create(TimeSpan.Zero, false));

    vars.update_statistics(game);
  });
  timer.OnStart += vars.timer_OnStart;
}

init
{
  refreshRate = 60;

  // 計測開始
  vars.started = (Func<bool>) (() => {
    var res = vars.w["Started?"].Old == 0 && vars.w["Started?"].Current != 0;
    if (settings["Spell Practice Run"]) {
      res = res && vars.in_sp();
    } else if (settings["All Last Words Run"]) {
      res = res && vars.in_sp() && vars.get_current_spellcard() == 205;
    } else {
      res = res && !vars.in_sp();
    }
    return res;
  });

  // リセット
  vars.interrupted = (Func<bool>) (() => {
    if (settings["Spell Practice Run"] || settings["All Last Words Run"]) {
      return false;
    }
    var res = vars.w["Started?"].Old != 0 && vars.w["Started?"].Current == 0;
    return res;
  });

  // ポーズ中
  vars.in_pause = (Func<bool>) (() => {
    return (vars.w["st_b8"].Current & 0x20000) != 0;
  });

  // リプレイ再生中
  vars.in_replay = (Func<bool>) (() => {
    return (vars.w["st_b4"].Current & 0x08) != 0;
  });

  // スペルプラクティス
  vars.in_sp = (Func<bool>) (() => {
    return (vars.w["st_b4"].Current & 0x4000) != 0x00;
  });

  // 現在のスペルカード(スペルプラクティスにも対応)
  vars.get_current_spellcard = (Func<int>) (() => {
    return (vars.in_sp()
            ? vars.w["st_b8"].Current & 0xff
            : vars.w["Spell Card No"].Current);
  });

  // スペルプラクティス中に死亡
  vars.sp_dead = (Func<bool>) (() => {
    return vars.w["Spell Card Bonus"].Old != 0 && vars.w["Spell Card Bonus"].Current == 0;
  });

  // スペルプラクティス中断
  vars.sp_interepted = (Func<bool>) (() => {
    // retry or title
    return (vars.w["in Spell Card?"].Old != 0 && vars.w["in Spell Card?"].Current == 0 && vars.w["Spell Card Bonus"].Current == 0
            || vars.w["SP Gone to Title?"].Old != 0 && vars.w["SP Gone to Title?"].Current == 0);
  });

  vars.sp_attempt_started = (Func<bool>) (() => {
    return vars.w["Spell Card Bonus"].Old == 0 && vars.w["Spell Card Bonus"].Current != 0;
  });

  // スペルプラクティスクリア
  vars.sp_cleared = (Func<bool>) (() => {
    // last spell card of All Last Words Run.
    if (settings["Split on Menu in Spell Practice"]
        || settings["All Last Words Run"] && vars.spellcard_count >= vars.spellcards_number_lw - 1) {
      return (vars.w["st_b8"].Current & 0x1000000) != 0 && vars.w["st_b4"].Changed && vars.w["st_b4"].Current == 0x0003c101;
    } else {
      return vars.w["SP Cleared?"].Old == 0 && vars.w["SP Cleared?"].Current != 0;
    }
  });

  // ボス登場
  vars.boss_appears = (Func<string, int, bool>) ((key, prev_scno) => {
    if (!(vars.w["Boss Exists?"].Old == 0 && vars.w["Boss Exists?"].Current != 0))
      return false;

    // return vars.get_current_spellcard() == prev_scno;

    if (key.Contains("[Extra]")) {
      if (key.Contains("Keine"))
        return vars.get_current_spellcard() == 0;
      else if (key.Contains("Mokou"))
        return vars.get_current_spellcard() == 193;
    }

    return false;
  });

  // scno番(0-indexed)のスペルカード終了
  vars.spellcard_ended = (Func<int, bool>) ((scno) => {
    return (vars.w["in Spell Card?"].Old != 0
            && vars.w["in Spell Card?"].Current == 0
            && vars.get_current_spellcard() == scno);
  });

  // 通常攻撃終了(次がnext_scno番(0-indexed)のスペルカード)
  vars.nonspell_ended = (Func<int, bool>) ((next_scno) => {
    return (vars.w["in Spell Card?"].Old == 0
            && vars.w["in Spell Card?"].Current != 0
            && vars.get_current_spellcard() == next_scno);
  });

  // クリアフラグを立てる
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

  // 死亡回数
  vars.get_death_count = (Func<int>)(() => {
    if (settings["Spell Practice Run"] || settings["All Last Words Run"]) {
      return vars.death_count;
    } else {
      return vars.w["Death Count"].Current;
    }
  });

  // ボム回数
  vars.get_bomb_count = (Func<int>)(() => {
    return vars.w["Bomb Count"].Current;
  });

  // スペルカード取得回数
  vars.get_spellcard_count = (Func<int>)(() => {
    if (!settings["Spell Practice Run"] && !settings["All Last Words Run"]) {
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

  // 統計更新
  vars.update_statistics = (Func<Process, bool>)((proc) => {
    if (!settings["Show Statistics"]) {
      return false;
    }

    if (!settings["Spell Practice Run"]) {
      if (vars.tcss.Count > 0) {
        // left: Spell Card Count
        var spellcards_number = vars.spellcards_number;
        var death_label = "Death";
        if (settings["All Last Words Run"]) {
          spellcards_number = vars.spellcards_number_lw;
          death_label = "Failure";
        } else if (settings["<Parent> [Extra]"]) {
          spellcards_number = vars.spellcards_number_ex;
        }
        vars.tcss[0].Text1 = string.Format("Spell Card: {0:d}/{1:d}", vars.spellcard_count, spellcards_number);
    
        // right: Death Count
        vars.tcss[0].Text2 = string.Format("{0:s}: {1:d}", death_label, vars.get_death_count());
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

        double times_per_hour = (vars.recent_average_timespan != TimeSpan.Zero
                                 ? (double)TimeSpan.FromHours(1).Ticks / (double)vars.recent_average_timespan.Ticks
                                 : 0.0);
        vars.tcss[1].Text2 = string.Format("{0:m\\:ss\\.f} ({1:f1}/h)", vars.recent_average_timespan, times_per_hour);
      }
      // 3rd line: Combo
      if (vars.tcss.Count > 2) {
        vars.tcss[2].Text1 = "Combo";
        vars.tcss[2].Text2 = string.Format("{0:d} (max: {1:d})", vars.current_combo, vars.max_combo);
      }
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

  if (settings["Spell Practice Run"] || settings["All Last Words Run"]) {
    vars.sp_attempting |= vars.sp_attempt_started();
  } else {
    vars.update |= vars.w["Death Count"].Changed || vars.w["Bomb Count"].Changed;
  }
  if (!settings["Spell Practice Run"]) {
    var current_spellcard_count = vars.get_spellcard_count();
    vars.update |= (vars.spellcard_count != current_spellcard_count);
    vars.spellcard_count = current_spellcard_count;
    // print(current_spellcard_count.ToString());
  }

  if (vars.update) {
    vars.update_statistics(game);
    vars.update = false;
  }
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
  if (vars.split_counter > 0) {
    if (--vars.split_counter > 0) {
      return false;
    }

    if (!settings["Show Statistics"]) {
      return vars.succeed;
    }

    if (!settings["Spell Practice Run"]) {
      if (!vars.succeed) {
        ++vars.death_count;
      }
    } else {
      var v = vars.history.Peek();
      var history_top_timespan = v.Item1;
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

      var current_timespan = timer.CurrentTime.RealTime.Value;
      var elapsed_timespan = current_timespan - history_top_timespan;
      vars.recent_average_timespan = (vars.history_success_count != 0
                                      ? TimeSpan.FromTicks(elapsed_timespan.Ticks / vars.history_success_count)
                                      : TimeSpan.Zero);

      if (vars.history.Count == vars.history_number) {
        vars.history.Dequeue();
      }
      var new_elem = Tuple.Create(current_timespan, vars.succeed);
      vars.history.Enqueue(new_elem);

      if (vars.DEBUG) {
        var i = 0;
        foreach (var vv in vars.history) {
          print(string.Format("{0:d}: {1:hh\\:mm\\:ss\\.f} {2:g}", i, vv.Item1, vv.Item2));
          ++i;
        }
      }
    }
    vars.update = true;

    return vars.succeed;
  }

  if (settings["Spell Practice Run"] || settings["All Last Words Run"]) {
    if (vars.sp_attempting) {
      if (vars.sp_cleared()) {
        if (vars.DEBUG) {
          print("b0: " + vars.w["st_b0"].Current.ToString("X"));
          print("b4: " + vars.w["st_b4"].Old.ToString("X") + " => " + vars.w["st_b4"].Current.ToString("X"));
          print("b8: " + vars.w["st_b8"].Current.ToString("X"));
        }
        if (settings["Spell Practice Run"]
            || settings["All Last Words Run"] && vars.set_clear_flag(vars.get_current_spellcard())) {
          vars.split_counter = vars.split_spok_delay;
          vars.succeed = true;
        }
        vars.sp_attempting = false;
      } else if (vars.sp_dead() || vars.sp_interepted()) {
        vars.split_counter = vars.split_delay;
        vars.succeed = false;
        vars.sp_attempting = false;
      }
    }
    return false;
  }

  // else
  foreach (var kv in vars.splits) {
    var key = kv.Key;
    var val = kv.Value;
    if (!settings[key])
      continue;

    var ok = false;
    if (key.Contains("{Boss Appears}")) {
      ok = vars.boss_appears(key, val);
    } else if (key.Contains("{Spell Card}")) {
      ok = vars.spellcard_ended(val);
    } else if (key.Contains("{Nonspell}")) {
      ok = vars.nonspell_ended(val);
    } else if (key.EndsWith("Stage Clear")) {
      if (vars.get_spellcard_count() < 7) {
        ok = vars.spellcard_ended(203);
      } else {
        ok = vars.spellcard_ended(204);
      }
    } else {
      print("[ASL] Unknown Split Key: " + key);
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

shutdown
{
  timer.OnStart -= vars.timer_OnStart;
}

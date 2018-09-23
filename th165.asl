// Please move your "scoreth095.dat", "scoreth165_bk.dat" and "savedata" directory to other directory before running.

state("th165", "ver 1.00a")
{
  int dreams_offset : 0x0b5660;
}

// English Patched
// state("th165e", "ver 1.00a")
// {
//   int dreams_offset : 0x0b5660;
// }

startup
{
  vars.dreams_size = 103;

  vars.dreams_offset = IntPtr.Zero;
  vars.info_offset = IntPtr.Zero;

  vars.old_clear_count = 0;
  vars.current_clear_count = 0;

  vars.cleared_flags = new bool[vars.dreams_size];

  // val, settingkey, label, tooltip, enabled, visible
  var split_defs = new List<Tuple<int, string, string, string, bool, bool>> {
    Tuple.Create(0, "Diary-4 Shot", "Split on final shot on Diary-4", "End timing on SRC rules", true, true),
    Tuple.Create(-1, "<Parent> [Unlock]", "Unlock Splits", "", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][ESP]", "ESP", "", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][First Week]", "First Week", "", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][Wrong Week]", "Wrong Week", "a.k.a 2nd Week", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][Nightmare Week]", "Nightmare Week", "a.k.a 3rd Week", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][Nightmare Diary]", "Nightmare Diary", "", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][End Screen]", "End Screen", "", true, true),
    Tuple.Create(2, "[Unlock][ESP] Lv1", "Lv1", "Bullet Cancel on Sun-2", false, true),
    Tuple.Create(3, "[Unlock][ESP] Lv2", "Lv2", "Tereportation on Wed-1", false, true),
    Tuple.Create(4, "[Unlock][ESP] Lv3", "Lv3", "Telephotography on Sat-1", false, true),
    Tuple.Create(5, "[Unlock][ESP] Lv4", "Lv4", "Pyrokinesis on 2nd Wed-1", true, true),
    Tuple.Create(6, "[Unlock][ESP] Lv5", "Lv5", "Death Cancel on 2nd Sat-6", true, true),
    Tuple.Create(0, "[Unlock][First Week] Clear Sun-2", "Clear Sun-2", "", true, false),
    Tuple.Create(1, "[Unlock][First Week] Unknown", "Unknown", "", false, false),
    Tuple.Create(7, "[Unlock][First Week] Sunday and Monday", "Sunday and Monday", "", false, true),
    Tuple.Create(8, "[Unlock][First Week] Tuesday", "Tuesday", "", false, true),
    Tuple.Create(9, "[Unlock][First Week] Wednesday", "Wednesday", "", false, true),
    Tuple.Create(10, "[Unlock][First Week] Thursday", "Thursday", "", false, true),
    Tuple.Create(11, "[Unlock][First Week] Friday", "Friday", "", false, true),
    Tuple.Create(12, "[Unlock][First Week] Saturday", "Saturday", "", false, true),
    Tuple.Create(13, "[Unlock][Wrong Week] Sunday", "Sunday", "", false, true),
    Tuple.Create(14, "[Unlock][Wrong Week] Monday", "Monday", "", false, true),
    Tuple.Create(15, "[Unlock][Wrong Week] Tuesday", "Tuesday", "", false, true),
    Tuple.Create(16, "[Unlock][Wrong Week] Wednesday", "Wednesday", "", false, true),
    Tuple.Create(17, "[Unlock][Wrong Week] Thursday", "Thursday", "", false, true),
    Tuple.Create(18, "[Unlock][Wrong Week] Friday", "Friday", "", false, true),
    Tuple.Create(19, "[Unlock][Wrong Week] Saturday", "Saturday", "", false, true),
    Tuple.Create(28, "[Unlock][Wrong Week] Sat-6", "Sat-6", "", false, true),
    Tuple.Create(20, "[Unlock][Nightmare Week] Sunday", "Sunday", "", false, true),
    Tuple.Create(21, "[Unlock][Nightmare Week] Monday", "Monday", "", false, true),
    Tuple.Create(22, "[Unlock][Nightmare Week] Tuesday", "Tuesday", "", false, true),
    Tuple.Create(23, "[Unlock][Nightmare Week] Wednesday", "Wednesday", "", false, true),
    Tuple.Create(24, "[Unlock][Nightmare Week] Thursday", "Thursday", "", false, true),
    Tuple.Create(25, "[Unlock][Nightmare Week] Friday", "Friday", "", false, true),
    Tuple.Create(26, "[Unlock][Nightmare Week] Saturday", "Saturday", "", false, true),
    Tuple.Create(27, "[Unlock][Nightmare Diary] Diary-1", "Diary-1", "", false, true),
    Tuple.Create(29, "[Unlock][Nightmare Diary] Diary-2", "Diary-2", "", false, true),
    Tuple.Create(30, "[Unlock][Nightmare Diary] Diary-3", "Diary-3", "", false, true),
    Tuple.Create(31, "[Unlock][Nightmare Diary] Diary-4", "Diary-4", "", false, true),
    Tuple.Create(32, "[Unlock][End Screen] Any%", "Any% End", "", false, true),
    Tuple.Create(33, "[Unlock][End Screen] All Dreams", "All Dreams End", "", false, true),
    Tuple.Create(-1, "<Parent> [Clear Count]", "Clear Count Splits", "How many Nightmares have you conquered?", true, true),
    Tuple.Create(10, "[Clear Count] 10 Dreams", "10 Dreams", "", true, true),
    Tuple.Create(20, "[Clear Count] 20 Dreams", "20 Dreams", "", true, true),
    Tuple.Create(30, "[Clear Count] 30 Dreams", "30 Dreams", "", true, true),
    Tuple.Create(40, "[Clear Count] 40 Dreams", "40 Dreams", "", true, true),
    Tuple.Create(50, "[Clear Count] 50 Dreams", "50 Dreams", "", true, true),
    Tuple.Create(60, "[Clear Count] 60 Dreams", "60 Dreams", "", true, true),
    Tuple.Create(70, "[Clear Count] 70 Dreams", "70 Dreams", "", true, true),
    Tuple.Create(80, "[Clear Count] 80 Dreams", "80 Dreams", "", true, true),
    Tuple.Create(90, "[Clear Count] 90 Dreams", "90 Dreams", "", true, true),
    Tuple.Create(100, "[Clear Count] 100 Dreams", "100 Dreams", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual]", "Individual Splits", "for Lunatic runners", true, true),
    Tuple.Create(-1, "<Parent> [Individual][First Week]", "First Week", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Wrong Week]", "Wrong Week", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Nightmare Week]", "Nightmare Week", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Nightmare Diary]", "Nightmare Diary", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][First Week][Sunday]", "Sunday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][First Week][Monday]", "Monday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][First Week][Tuesday]", "Tuesday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][First Week][Wednesday]", "Wednesday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][First Week][Thursday]", "Thursday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][First Week][Friday]", "Friday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][First Week][Saturday]", "Saturday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Wrong Week][Sunday]", "Sunday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Wrong Week][Monday]", "Monday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Wrong Week][Tuesday]", "Tuesday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Wrong Week][Wednesday]", "Wednesday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Wrong Week][Thursday]", "Thursday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Wrong Week][Friday]", "Friday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Wrong Week][Saturday]", "Saturday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Nightmare Week][Sunday]", "Sunday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Nightmare Week][Monday]", "Monday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Nightmare Week][Tuesday]", "Tuesday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Nightmare Week][Wednesday]", "Wednesday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Nightmare Week][Thursday]", "Thursday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Nightmare Week][Friday]", "Friday", "", true, true),
    Tuple.Create(-1, "<Parent> [Individual][Nightmare Week][Saturday]", "Saturday", "", true, true),
    Tuple.Create(0, "[Individual][First Week][Sunday] Sun-1", "Sun-1", "", false, true),
    Tuple.Create(1, "[Individual][First Week][Sunday] Sun-2", "Sun-2", "", false, true),
    Tuple.Create(2, "[Individual][First Week][Monday] Mon-1", "Mon-1", "", false, true),
    Tuple.Create(3, "[Individual][First Week][Monday] Mon-2", "Mon-2", "", false, true),
    Tuple.Create(4, "[Individual][First Week][Monday] Mon-3", "Mon-3", "", false, true),
    Tuple.Create(5, "[Individual][First Week][Monday] Mon-4", "Mon-4", "", false, true),
    Tuple.Create(6, "[Individual][First Week][Tuesday] Tue-1", "Tue-1", "", false, true),
    Tuple.Create(7, "[Individual][First Week][Tuesday] Tue-2", "Tue-2", "", false, true),
    Tuple.Create(8, "[Individual][First Week][Tuesday] Tue-3", "Tue-3", "", false, true),
    Tuple.Create(9, "[Individual][First Week][Wednesday] Wed-1", "Wed-1", "", false, true),
    Tuple.Create(10, "[Individual][First Week][Wednesday] Wed-2", "Wed-2", "", false, true),
    Tuple.Create(11, "[Individual][First Week][Wednesday] Wed-3", "Wed-3", "", false, true),
    Tuple.Create(12, "[Individual][First Week][Wednesday] Wed-4", "Wed-4", "", false, true),
    Tuple.Create(13, "[Individual][First Week][Thursday] Thu-1", "Thu-1", "", false, true),
    Tuple.Create(14, "[Individual][First Week][Thursday] Thu-2", "Thu-2", "", false, true),
    Tuple.Create(15, "[Individual][First Week][Thursday] Thu-3", "Thu-3", "", false, true),
    Tuple.Create(16, "[Individual][First Week][Friday] Fri-1", "Fri-1", "", false, true),
    Tuple.Create(17, "[Individual][First Week][Friday] Fri-2", "Fri-2", "", false, true),
    Tuple.Create(18, "[Individual][First Week][Friday] Fri-3", "Fri-3", "", false, true),
    Tuple.Create(19, "[Individual][First Week][Saturday] Sat-1", "Sat-1", "", false, true),
    Tuple.Create(20, "[Individual][Wrong Week][Sunday] 2nd Sun-1", "2nd Sun-1", "", false, true),
    Tuple.Create(21, "[Individual][Wrong Week][Sunday] 2nd Sun-2", "2nd Sun-2", "", false, true),
    Tuple.Create(22, "[Individual][Wrong Week][Sunday] 2nd Sun-3", "2nd Sun-3", "", false, true),
    Tuple.Create(23, "[Individual][Wrong Week][Sunday] 2nd Sun-4", "2nd Sun-4", "", false, true),
    Tuple.Create(24, "[Individual][Wrong Week][Sunday] 2nd Sun-5", "2nd Sun-5", "", false, true),
    Tuple.Create(25, "[Individual][Wrong Week][Sunday] 2nd Sun-6", "2nd Sun-6", "", false, true),
    Tuple.Create(26, "[Individual][Wrong Week][Sunday] 2nd Sun-7", "2nd Sun-7", "", false, true),
    Tuple.Create(27, "[Individual][Wrong Week][Monday] 2nd Mon-1", "2nd Mon-1", "", false, true),
    Tuple.Create(28, "[Individual][Wrong Week][Monday] 2nd Mon-2", "2nd Mon-2", "", false, true),
    Tuple.Create(29, "[Individual][Wrong Week][Monday] 2nd Mon-3", "2nd Mon-3", "", false, true),
    Tuple.Create(30, "[Individual][Wrong Week][Monday] 2nd Mon-4", "2nd Mon-4", "", false, true),
    Tuple.Create(31, "[Individual][Wrong Week][Tuesday] 2nd Tue-1", "2nd Tue-1", "", false, true),
    Tuple.Create(32, "[Individual][Wrong Week][Tuesday] 2nd Tue-2", "2nd Tue-2", "", false, true),
    Tuple.Create(33, "[Individual][Wrong Week][Tuesday] 2nd Tue-3", "2nd Tue-3", "", false, true),
    Tuple.Create(34, "[Individual][Wrong Week][Tuesday] 2nd Tue-4", "2nd Tue-4", "", false, true),
    Tuple.Create(35, "[Individual][Wrong Week][Wednesday] 2nd Wed-1", "2nd Wed-1", "", false, true),
    Tuple.Create(36, "[Individual][Wrong Week][Wednesday] 2nd Wed-2", "2nd Wed-2", "", false, true),
    Tuple.Create(37, "[Individual][Wrong Week][Wednesday] 2nd Wed-3", "2nd Wed-3", "", false, true),
    Tuple.Create(38, "[Individual][Wrong Week][Wednesday] 2nd Wed-4", "2nd Wed-4", "", false, true),
    Tuple.Create(39, "[Individual][Wrong Week][Wednesday] 2nd Wed-5", "2nd Wed-5", "", false, true),
    Tuple.Create(40, "[Individual][Wrong Week][Wednesday] 2nd Wed-6", "2nd Wed-6", "", false, true),
    Tuple.Create(41, "[Individual][Wrong Week][Thursday] 2nd Thu-1", "2nd Thu-1", "", false, true),
    Tuple.Create(42, "[Individual][Wrong Week][Thursday] 2nd Thu-2", "2nd Thu-2", "", false, true),
    Tuple.Create(43, "[Individual][Wrong Week][Thursday] 2nd Thu-3", "2nd Thu-3", "", false, true),
    Tuple.Create(44, "[Individual][Wrong Week][Thursday] 2nd Thu-4", "2nd Thu-4", "", false, true),
    Tuple.Create(45, "[Individual][Wrong Week][Thursday] 2nd Thu-5", "2nd Thu-5", "", false, true),
    Tuple.Create(46, "[Individual][Wrong Week][Friday] 2nd Fri-1", "2nd Fri-1", "", false, true),
    Tuple.Create(47, "[Individual][Wrong Week][Friday] 2nd Fri-2", "2nd Fri-2", "", false, true),
    Tuple.Create(48, "[Individual][Wrong Week][Friday] 2nd Fri-3", "2nd Fri-3", "", false, true),
    Tuple.Create(49, "[Individual][Wrong Week][Friday] 2nd Fri-4", "2nd Fri-4", "", false, true),
    Tuple.Create(50, "[Individual][Wrong Week][Friday] 2nd Fri-5", "2nd Fri-5", "", false, true),
    Tuple.Create(51, "[Individual][Wrong Week][Saturday] 2nd Sat-1", "2nd Sat-1", "", false, true),
    Tuple.Create(52, "[Individual][Wrong Week][Saturday] 2nd Sat-2", "2nd Sat-2", "", false, true),
    Tuple.Create(53, "[Individual][Wrong Week][Saturday] 2nd Sat-3", "2nd Sat-3", "", false, true),
    Tuple.Create(54, "[Individual][Wrong Week][Saturday] 2nd Sat-4", "2nd Sat-4", "", false, true),
    Tuple.Create(55, "[Individual][Wrong Week][Saturday] 2nd Sat-5", "2nd Sat-5", "", false, true),
    Tuple.Create(56, "[Individual][Wrong Week][Saturday] 2nd Sat-6", "2nd Sat-6", "", false, true),
    Tuple.Create(57, "[Individual][Nightmare Week][Sunday] 3rd Sun-1", "3rd Sun-1", "", false, true),
    Tuple.Create(58, "[Individual][Nightmare Week][Sunday] 3rd Sun-2", "3rd Sun-2", "", false, true),
    Tuple.Create(59, "[Individual][Nightmare Week][Sunday] 3rd Sun-3", "3rd Sun-3", "", false, true),
    Tuple.Create(60, "[Individual][Nightmare Week][Sunday] 3rd Sun-4", "3rd Sun-4", "", false, true),
    Tuple.Create(61, "[Individual][Nightmare Week][Sunday] 3rd Sun-5", "3rd Sun-5", "", false, true),
    Tuple.Create(62, "[Individual][Nightmare Week][Sunday] 3rd Sun-6", "3rd Sun-6", "", false, true),
    Tuple.Create(63, "[Individual][Nightmare Week][Monday] 3rd Mon-1", "3rd Mon-1", "", false, true),
    Tuple.Create(64, "[Individual][Nightmare Week][Monday] 3rd Mon-2", "3rd Mon-2", "", false, true),
    Tuple.Create(65, "[Individual][Nightmare Week][Monday] 3rd Mon-3", "3rd Mon-3", "", false, true),
    Tuple.Create(66, "[Individual][Nightmare Week][Monday] 3rd Mon-4", "3rd Mon-4", "", false, true),
    Tuple.Create(67, "[Individual][Nightmare Week][Monday] 3rd Mon-5", "3rd Mon-5", "", false, true),
    Tuple.Create(68, "[Individual][Nightmare Week][Monday] 3rd Mon-6", "3rd Mon-6", "", false, true),
    Tuple.Create(69, "[Individual][Nightmare Week][Tuesday] 3rd Tue-1", "3rd Tue-1", "", false, true),
    Tuple.Create(70, "[Individual][Nightmare Week][Tuesday] 3rd Tue-2", "3rd Tue-2", "", false, true),
    Tuple.Create(71, "[Individual][Nightmare Week][Tuesday] 3rd Tue-3", "3rd Tue-3", "", false, true),
    Tuple.Create(72, "[Individual][Nightmare Week][Tuesday] 3rd Tue-4", "3rd Tue-4", "", false, true),
    Tuple.Create(73, "[Individual][Nightmare Week][Tuesday] 3rd Tue-5", "3rd Tue-5", "", false, true),
    Tuple.Create(74, "[Individual][Nightmare Week][Tuesday] 3rd Tue-6", "3rd Tue-6", "", false, true),
    Tuple.Create(75, "[Individual][Nightmare Week][Wednesday] 3rd Wed-1", "3rd Wed-1", "", false, true),
    Tuple.Create(76, "[Individual][Nightmare Week][Wednesday] 3rd Wed-2", "3rd Wed-2", "", false, true),
    Tuple.Create(77, "[Individual][Nightmare Week][Wednesday] 3rd Wed-3", "3rd Wed-3", "", false, true),
    Tuple.Create(78, "[Individual][Nightmare Week][Wednesday] 3rd Wed-4", "3rd Wed-4", "", false, true),
    Tuple.Create(79, "[Individual][Nightmare Week][Wednesday] 3rd Wed-5", "3rd Wed-5", "", false, true),
    Tuple.Create(80, "[Individual][Nightmare Week][Wednesday] 3rd Wed-6", "3rd Wed-6", "", false, true),
    Tuple.Create(81, "[Individual][Nightmare Week][Thursday] 3rd Thu-1", "3rd Thu-1", "", false, true),
    Tuple.Create(82, "[Individual][Nightmare Week][Thursday] 3rd Thu-2", "3rd Thu-2", "", false, true),
    Tuple.Create(83, "[Individual][Nightmare Week][Thursday] 3rd Thu-3", "3rd Thu-3", "", false, true),
    Tuple.Create(84, "[Individual][Nightmare Week][Thursday] 3rd Thu-4", "3rd Thu-4", "", false, true),
    Tuple.Create(85, "[Individual][Nightmare Week][Thursday] 3rd Thu-5", "3rd Thu-5", "", false, true),
    Tuple.Create(86, "[Individual][Nightmare Week][Thursday] 3rd Thu-6", "3rd Thu-6", "", false, true),
    Tuple.Create(87, "[Individual][Nightmare Week][Friday] 3rd Fri-1", "3rd Fri-1", "", false, true),
    Tuple.Create(88, "[Individual][Nightmare Week][Friday] 3rd Fri-2", "3rd Fri-2", "", false, true),
    Tuple.Create(89, "[Individual][Nightmare Week][Friday] 3rd Fri-3", "3rd Fri-3", "", false, true),
    Tuple.Create(90, "[Individual][Nightmare Week][Friday] 3rd Fri-4", "3rd Fri-4", "", false, true),
    Tuple.Create(91, "[Individual][Nightmare Week][Friday] 3rd Fri-5", "3rd Fri-5", "", false, true),
    Tuple.Create(92, "[Individual][Nightmare Week][Friday] 3rd Fri-6", "3rd Fri-6", "", false, true),
    Tuple.Create(93, "[Individual][Nightmare Week][Saturday] 3rd Sat-1", "3rd Sat-1", "", false, true),
    Tuple.Create(94, "[Individual][Nightmare Week][Saturday] 3rd Sat-2", "3rd Sat-2", "", false, true),
    Tuple.Create(95, "[Individual][Nightmare Week][Saturday] 3rd Sat-3", "3rd Sat-3", "", false, true),
    Tuple.Create(96, "[Individual][Nightmare Week][Saturday] 3rd Sat-4", "3rd Sat-4", "", false, true),
    Tuple.Create(97, "[Individual][Nightmare Week][Saturday] 3rd Sat-5", "3rd Sat-5", "", false, true),
    Tuple.Create(98, "[Individual][Nightmare Week][Saturday] 3rd Sat-6", "3rd Sat-6", "", false, true),
    Tuple.Create(99, "[Individual][Nightmare Diary] Diary-1", "Diary-1", "", false, true),
    Tuple.Create(100, "[Individual][Nightmare Diary] Diary-2", "Diary-2", "", false, true),
    Tuple.Create(101, "[Individual][Nightmare Diary] Diary-3", "Diary-3", "", false, true),
    Tuple.Create(102, "[Individual][Nightmare Diary] Diary-4", "Diary-4", "not recommended due to Diary-4 Shot Split", false, true),
  };

  settings.Add("Automatically Start", true, "Start on \"Game Start\" with new game");
  settings.SetToolTip("Automatically Start", "Start timing on SRC rules");

  settings.Add("Automatically Reset", true, "Reset when game is restarted with new game");

  settings.Add("Show Counts", true, "Show Clear/Death/DeathCancel Counts");
  settings.SetToolTip("Show Counts", "Override first text component with some counts");

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

  vars.getMemoryWatcherList = (Func<Process, MemoryWatcherList>)((proc) => {
    return new MemoryWatcherList {
//       new MemoryWatcher<int>((IntPtr)0x4b3a98) { Name = "Survive?" },
//       new MemoryWatcher<int>((IntPtr)0x4b3b04) { Name = "Start Time" },
      new MemoryWatcher<int>((IntPtr)0x4b3ce0) { Name = "Start?" },
      new MemoryWatcher<int>((IntPtr)0x4b5670) { Name = "in Game?" },
      new MemoryWatcher<int>(vars.dreams_offset + 0x20) { Name = "Sun-1 Try Count" },
      new MemoryWatcher<int>(vars.dreams_offset + 0x234 * 102 + 0x24) { Name = "Diary-4 Shot Count" },
      new MemoryWatcher<int>(vars.info_offset + 0x54) { Name = "Play Time" },
//       new MemoryWatcher<int>(vars.info_offset + 0x5c) { Name = "Current Day" },
//       new MemoryWatcher<int>(vars.info_offset + 0x140) { Name = "ESP Level" },
      new MemoryWatcher<int>(vars.info_offset + 0x144) { Name = "Death Count" },
//       new MemoryWatcher<int>(info_offset + 0x148) { Name = "Teleportation Count" },
      new MemoryWatcher<int>(vars.info_offset + 0x14c) { Name = "Death Cancel Count" },
    };
  });

  vars.count_cleared_dreams = (Func<Process, int>)((proc) => {
    var count = 0;

    for (int i = 0; i < vars.dreams_size; ++i) {
      var flg = proc.ReadValue<int>((IntPtr)vars.dreams_offset + 0x234 * i + 0x1c) != 0;

      vars.cleared_flags[i] = flg;
      if (flg)
        ++count;
    }
    return count;
  });

  vars.is_cleared = (Func<Process, int, bool>)((proc, idx) => {
    // return proc.ReadValue<byte>((IntPtr)vars.dreams_offset + 0x234 * idx + 0x1c) != 0;
    return vars.cleared_flags[idx];
  });

  vars.is_unlocked = (Func<Process, int, bool>)((proc, idx) => {
    return proc.ReadValue<byte>((IntPtr)vars.info_offset + 0x64 + idx) != 0;
  });

  vars.has_trophy = (Func<Process, int, bool>)((proc, idx) => {
    return proc.ReadValue<byte>((IntPtr)vars.info_offset + 0xa4 + idx) != 0;
  });

  vars.check_story_flag = (Func<Process, int, bool>)((proc, idx) => {
    return proc.ReadValue<byte>((IntPtr)vars.info_offset + 0x134 + idx) != 0;
  });

  vars.in_game = (Func<bool>) (() => {
    return vars.w["in Game?"].Current != 1;
  });

  vars.tcs = null;
  foreach (LiveSplit.UI.Components.IComponent component in timer.Layout.Components) {
    if (component.GetType().Name == "TextComponent") {
      vars.tc = component;
      vars.tcs = vars.tc.Settings;
      print("[ASL] Found text component at " + component);
      break;
    }
  }

}

init
{
  refreshRate = 60;

  vars.update_coounts = (Func<Process, bool, bool>)((proc, force) => {
    vars.current_clear_count = vars.count_cleared_dreams(proc);

    var updated = (settings["Show Counts"]
                   && vars.tcs != null
                   && (force
                       || vars.old_clear_count != vars.current_clear_count
                       || vars.w["Death Count"].Changed
                       || vars.w["Death Cancel Count"].Changed));
    if (updated) {
      // left: Clear Count
      vars.tcs.Text1 = "Cleared: " + vars.current_clear_count + "/" + vars.dreams_size.ToString();
      // right: Death Count and Death Cancel Count
      vars.tcs.Text2 = ("Death Count: " + vars.w["Death Count"].Current.ToString()
                        + " (" + vars.w["Death Cancel Count"].Current.ToString() + ")");
    }
    vars.old_clear_count = vars.current_clear_count;
    return updated;
  });

  vars.dreams_offset = (IntPtr)current.dreams_offset;
  vars.info_offset = (IntPtr)(current.dreams_offset + 0x234 * vars.dreams_size);
  vars.w = vars.getMemoryWatcherList(game);

  vars.update_coounts(game, true);
}

update
{
  if (old.dreams_offset != current.dreams_offset) {
    vars.dreams_offset = (IntPtr)current.dreams_offset;
    vars.info_offset = (IntPtr)(current.dreams_offset + 0x234 * vars.dreams_size);
    print("[ASL] dreams_offset is changed: "
          + old.dreams_offset.ToString("x8")
          + " => "
          + current.dreams_offset.ToString("x8"));

    vars.w = vars.getMemoryWatcherList(game);
  } else {
    vars.w.UpdateAll(game);
  }

  vars.update_coounts(game, false);
}

start
{
  var res = (settings["Automatically Start"]
             && vars.w["Start?"].Old == 0
             && vars.w["Start?"].Current != 0);
  if (res)
    print("[ASL] Automatically Start");
  return res;
}

split
{
  foreach (var kv in vars.splits) {
    var key = kv.Key;
    var val = kv.Value;
    if (!settings[key])
      continue;

    var ok = false;
    if (key == "Diary-4 Shot") {
      ok = vars.w["Diary-4 Shot Count"].Current > 0;
    } else if (key.StartsWith("[Unlock]")) {
      ok = vars.is_unlocked(game, val);
    } else if (key.StartsWith("[Clear Count]")) {
      ok = vars.current_clear_count >= val;
    } else if (key.StartsWith("[Individual]")) {
      ok = vars.is_cleared(game, val);
    } else {
      print("[ASL] Unknown Splits Key: " + key);
    }

    if (ok) {
      print("[ASL] Split: " + key);
      vars.splits.Remove(key);
      return true;
    }
  }
}

reset
{
  var res = (settings["Automatically Reset"]
             && vars.w["Sun-1 Try Count"].Current == 0
             && vars.w["Start?"].Current == 0
             && !vars.in_game());
  if (res)
    print("[ASL] Automatically Reset");
  return res;
}

gameTime {
  var t = vars.w["Play Time"].Current;
  return TimeSpan.FromMilliseconds(t * 10);
}

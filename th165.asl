// Please move your "scoreth095.dat", "scoreth165_bk.dat" and "savedata" directory to other directory before run.

state("th165", "ver 1.00a")
{
  int states_offset : 0x0b552c;
  int dreams_offset : 0x0b5660;
}

// English Patched (for the future)
state("th165e", "ver 1.00a with English Patch")
{
  int states_offset : 0x0b552c;
  int dreams_offset : 0x0b5660;
}

startup
{
  vars.dreams_size = 103;
  vars.clear_flags = new bool[vars.dreams_size];

  vars.old_clear_count = 0;
  vars.current_clear_count = 0;
  vars.base_time = 0;

  vars.dreams_offset = IntPtr.Zero;
  vars.info_offset = IntPtr.Zero;

  vars.states_offset = IntPtr.Zero;

  // val, settingkey, label, tooltip, enabled, visible
  var split_defs = new List<Tuple<int, string, string, string, bool, bool>> {
    Tuple.Create(-1, "<Parent> [Unlock]", "Unlock Splits", "What elements have you unlocked?", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][ESP]", "ESP", "", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][First Week]", "First Week", "", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][Wrong Week]", "Wrong Week", "a.k.a 2nd Week", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][Nightmare Week]", "Nightmare Week", "a.k.a 3rd Week", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][Nightmare Diary]", "Nightmare Diary", "", true, true),
    Tuple.Create(-1, "<Parent> [Unlock][End Screen]", "End Screen", "", true, true),
    Tuple.Create(2, "[Unlock][ESP] Lv1", "Lv1", "\"Bullet Cancel\" on Sun-2", false, true),
    Tuple.Create(3, "[Unlock][ESP] Lv2", "Lv2", "\"Teleportation\" on Wed-1", false, true),
    Tuple.Create(4, "[Unlock][ESP] Lv3", "Lv3", "\"Telephotography\" on Sat-1", false, true),
    Tuple.Create(5, "[Unlock][ESP] Lv4", "Lv4", "\"Pyrokinesis\" on 2nd Wed-1", true, true),
    Tuple.Create(6, "[Unlock][ESP] Lv5", "Lv5", "\"Death Cancel\" on 2nd Sat-6", true, true),
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
    Tuple.Create(1, "[Clear Count] 1 Dream", "1 Dream", "", false, true),
    Tuple.Create(2, "[Clear Count] 2 Dreams", "2 Dreams", "", false, true),
    Tuple.Create(3, "[Clear Count] 3 Dreams", "3 Dreams", "", false, true),
    Tuple.Create(4, "[Clear Count] 4 Dreams", "4 Dreams", "", false, true),
    Tuple.Create(5, "[Clear Count] 5 Dreams", "5 Dreams", "", false, true),
    Tuple.Create(6, "[Clear Count] 6 Dreams", "6 Dreams", "", false, true),
    Tuple.Create(7, "[Clear Count] 7 Dreams", "7 Dreams", "", false, true),
    Tuple.Create(8, "[Clear Count] 8 Dreams", "8 Dreams", "", false, true),
    Tuple.Create(9, "[Clear Count] 9 Dreams", "9 Dreams", "", false, true),
    Tuple.Create(10, "[Clear Count] 10 Dreams", "10 Dreams", "", true, true),
    Tuple.Create(11, "[Clear Count] 11 Dreams", "11 Dreams", "", false, true),
    Tuple.Create(12, "[Clear Count] 12 Dreams", "12 Dreams", "", false, true),
    Tuple.Create(13, "[Clear Count] 13 Dreams", "13 Dreams", "", false, true),
    Tuple.Create(14, "[Clear Count] 14 Dreams", "14 Dreams", "", false, true),
    Tuple.Create(15, "[Clear Count] 15 Dreams", "15 Dreams", "", false, true),
    Tuple.Create(16, "[Clear Count] 16 Dreams", "16 Dreams", "", false, true),
    Tuple.Create(17, "[Clear Count] 17 Dreams", "17 Dreams", "", false, true),
    Tuple.Create(18, "[Clear Count] 18 Dreams", "18 Dreams", "", false, true),
    Tuple.Create(19, "[Clear Count] 19 Dreams", "19 Dreams", "", false, true),
    Tuple.Create(20, "[Clear Count] 20 Dreams", "20 Dreams", "", true, true),
    Tuple.Create(21, "[Clear Count] 21 Dreams", "21 Dreams", "", false, true),
    Tuple.Create(22, "[Clear Count] 22 Dreams", "22 Dreams", "", false, true),
    Tuple.Create(23, "[Clear Count] 23 Dreams", "23 Dreams", "", false, true),
    Tuple.Create(24, "[Clear Count] 24 Dreams", "24 Dreams", "", false, true),
    Tuple.Create(25, "[Clear Count] 25 Dreams", "25 Dreams", "", false, true),
    Tuple.Create(26, "[Clear Count] 26 Dreams", "26 Dreams", "", false, true),
    Tuple.Create(27, "[Clear Count] 27 Dreams", "27 Dreams", "", false, true),
    Tuple.Create(28, "[Clear Count] 28 Dreams", "28 Dreams", "", false, true),
    Tuple.Create(29, "[Clear Count] 29 Dreams", "29 Dreams", "", false, true),
    Tuple.Create(30, "[Clear Count] 30 Dreams", "30 Dreams", "", true, true),
    Tuple.Create(31, "[Clear Count] 31 Dreams", "31 Dreams", "", false, true),
    Tuple.Create(32, "[Clear Count] 32 Dreams", "32 Dreams", "", false, true),
    Tuple.Create(33, "[Clear Count] 33 Dreams", "33 Dreams", "", false, true),
    Tuple.Create(34, "[Clear Count] 34 Dreams", "34 Dreams", "", false, true),
    Tuple.Create(35, "[Clear Count] 35 Dreams", "35 Dreams", "", false, true),
    Tuple.Create(36, "[Clear Count] 36 Dreams", "36 Dreams", "", false, true),
    Tuple.Create(37, "[Clear Count] 37 Dreams", "37 Dreams", "", false, true),
    Tuple.Create(38, "[Clear Count] 38 Dreams", "38 Dreams", "", false, true),
    Tuple.Create(39, "[Clear Count] 39 Dreams", "39 Dreams", "", false, true),
    Tuple.Create(40, "[Clear Count] 40 Dreams", "40 Dreams", "", true, true),
    Tuple.Create(41, "[Clear Count] 41 Dreams", "41 Dreams", "", false, true),
    Tuple.Create(42, "[Clear Count] 42 Dreams", "42 Dreams", "", false, true),
    Tuple.Create(43, "[Clear Count] 43 Dreams", "43 Dreams", "", false, true),
    Tuple.Create(44, "[Clear Count] 44 Dreams", "44 Dreams", "", false, true),
    Tuple.Create(45, "[Clear Count] 45 Dreams", "45 Dreams", "", false, true),
    Tuple.Create(46, "[Clear Count] 46 Dreams", "46 Dreams", "", false, true),
    Tuple.Create(47, "[Clear Count] 47 Dreams", "47 Dreams", "", false, true),
    Tuple.Create(48, "[Clear Count] 48 Dreams", "48 Dreams", "", false, true),
    Tuple.Create(49, "[Clear Count] 49 Dreams", "49 Dreams", "", false, true),
    Tuple.Create(50, "[Clear Count] 50 Dreams", "50 Dreams", "", true, true),
    Tuple.Create(51, "[Clear Count] 51 Dreams", "51 Dreams", "", false, true),
    Tuple.Create(52, "[Clear Count] 52 Dreams", "52 Dreams", "", false, true),
    Tuple.Create(53, "[Clear Count] 53 Dreams", "53 Dreams", "", false, true),
    Tuple.Create(54, "[Clear Count] 54 Dreams", "54 Dreams", "", false, true),
    Tuple.Create(55, "[Clear Count] 55 Dreams", "55 Dreams", "", false, true),
    Tuple.Create(56, "[Clear Count] 56 Dreams", "56 Dreams", "", false, true),
    Tuple.Create(57, "[Clear Count] 57 Dreams", "57 Dreams", "", false, true),
    Tuple.Create(58, "[Clear Count] 58 Dreams", "58 Dreams", "", false, true),
    Tuple.Create(59, "[Clear Count] 59 Dreams", "59 Dreams", "", false, true),
    Tuple.Create(60, "[Clear Count] 60 Dreams", "60 Dreams", "", true, true),
    Tuple.Create(61, "[Clear Count] 61 Dreams", "61 Dreams", "", false, true),
    Tuple.Create(62, "[Clear Count] 62 Dreams", "62 Dreams", "", false, true),
    Tuple.Create(63, "[Clear Count] 63 Dreams", "63 Dreams", "", false, true),
    Tuple.Create(64, "[Clear Count] 64 Dreams", "64 Dreams", "", false, true),
    Tuple.Create(65, "[Clear Count] 65 Dreams", "65 Dreams", "", false, true),
    Tuple.Create(66, "[Clear Count] 66 Dreams", "66 Dreams", "", false, true),
    Tuple.Create(67, "[Clear Count] 67 Dreams", "67 Dreams", "", false, true),
    Tuple.Create(68, "[Clear Count] 68 Dreams", "68 Dreams", "", false, true),
    Tuple.Create(69, "[Clear Count] 69 Dreams", "69 Dreams", "", false, true),
    Tuple.Create(70, "[Clear Count] 70 Dreams", "70 Dreams", "", true, true),
    Tuple.Create(71, "[Clear Count] 71 Dreams", "71 Dreams", "", false, true),
    Tuple.Create(72, "[Clear Count] 72 Dreams", "72 Dreams", "", false, true),
    Tuple.Create(73, "[Clear Count] 73 Dreams", "73 Dreams", "", false, true),
    Tuple.Create(74, "[Clear Count] 74 Dreams", "74 Dreams", "", false, true),
    Tuple.Create(75, "[Clear Count] 75 Dreams", "75 Dreams", "", false, true),
    Tuple.Create(76, "[Clear Count] 76 Dreams", "76 Dreams", "", false, true),
    Tuple.Create(77, "[Clear Count] 77 Dreams", "77 Dreams", "", false, true),
    Tuple.Create(78, "[Clear Count] 78 Dreams", "78 Dreams", "", false, true),
    Tuple.Create(79, "[Clear Count] 79 Dreams", "79 Dreams", "", false, true),
    Tuple.Create(80, "[Clear Count] 80 Dreams", "80 Dreams", "", true, true),
    Tuple.Create(81, "[Clear Count] 81 Dreams", "81 Dreams", "", false, true),
    Tuple.Create(82, "[Clear Count] 82 Dreams", "82 Dreams", "", false, true),
    Tuple.Create(83, "[Clear Count] 83 Dreams", "83 Dreams", "", false, true),
    Tuple.Create(84, "[Clear Count] 84 Dreams", "84 Dreams", "", false, true),
    Tuple.Create(85, "[Clear Count] 85 Dreams", "85 Dreams", "", false, true),
    Tuple.Create(86, "[Clear Count] 86 Dreams", "86 Dreams", "", false, true),
    Tuple.Create(87, "[Clear Count] 87 Dreams", "87 Dreams", "", false, true),
    Tuple.Create(88, "[Clear Count] 88 Dreams", "88 Dreams", "", false, true),
    Tuple.Create(89, "[Clear Count] 89 Dreams", "89 Dreams", "", false, true),
    Tuple.Create(90, "[Clear Count] 90 Dreams", "90 Dreams", "", true, true),
    Tuple.Create(91, "[Clear Count] 91 Dreams", "91 Dreams", "", false, true),
    Tuple.Create(92, "[Clear Count] 92 Dreams", "92 Dreams", "", false, true),
    Tuple.Create(93, "[Clear Count] 93 Dreams", "93 Dreams", "", false, true),
    Tuple.Create(94, "[Clear Count] 94 Dreams", "94 Dreams", "", false, true),
    Tuple.Create(95, "[Clear Count] 95 Dreams", "95 Dreams", "", false, true),
    Tuple.Create(96, "[Clear Count] 96 Dreams", "96 Dreams", "", false, true),
    Tuple.Create(97, "[Clear Count] 97 Dreams", "97 Dreams", "", false, true),
    Tuple.Create(98, "[Clear Count] 98 Dreams", "98 Dreams", "", false, true),
    Tuple.Create(99, "[Clear Count] 99 Dreams", "99 Dreams", "", false, true),
    Tuple.Create(100, "[Clear Count] 100 Dreams", "100 Dreams", "", true, true),
    Tuple.Create(101, "[Clear Count] 101 Dreams", "101 Dreams", "", false, true),
    Tuple.Create(102, "[Clear Count] 102 Dreams", "102 Dreams", "", false, true),
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
    Tuple.Create(102, "[Individual][Nightmare Diary] Diary-4", "Diary-4", "not recommended due to the final photo split", false, true),
  };

  settings.Add("Auto Start", true, "Auto start on \"Game Start\" with new game");
  settings.SetToolTip("Auto Start", "Start timing on SRC rules");

  settings.Add("Diary-4 Shot", true, "Split on the final photo on Diary-4");
  settings.SetToolTip("Diary-4 Shot", "End timing on SRC rules");

  settings.Add("Auto Reset", true, "Auto reset when the game is restarted with new game");

  settings.Add("Show Counts", true, "Show Clear/Death/DeathCancel Count");
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
//       new MemoryWatcher<int>((IntPtr)0x4b3b04) { Name = "Base Time" },
      new MemoryWatcher<int>((IntPtr)0x4b3ce0) { Name = "Starting?" },
      new MemoryWatcher<int>((IntPtr)0x4b5670) { Name = "in Game?" },
      new MemoryWatcher<int>(vars.dreams_offset + 0x20) { Name = "Sun-1 Attempt Count" },
      new MemoryWatcher<int>(vars.dreams_offset + 0x234 * 102 + 0x24) { Name = "Diary-4 Shot Count" },
      new MemoryWatcher<int>(vars.info_offset + 0x54) { Name = "Total Play Time" },
//       new MemoryWatcher<int>(vars.info_offset + 0x5c) { Name = "Current Day" },
//       new MemoryWatcher<int>(vars.info_offset + 0x140) { Name = "ESP Level" },
      new MemoryWatcher<int>(vars.info_offset + 0x144) { Name = "Death Count" },
//       new MemoryWatcher<int>(info_offset + 0x148) { Name = "Teleportation Count" },
      new MemoryWatcher<int>(vars.info_offset + 0x14c) { Name = "Death Cancel Count" },
    };
  });

  vars.getMemoryWatcherList2 = (Func<Process, MemoryWatcherList>)((proc) => {
    return new MemoryWatcherList {
      new MemoryWatcher<int>(vars.states_offset + 0x84) { Name = "State Flags" },
      new MemoryWatcher<int>(vars.states_offset + 0x98) { Name = "in Replay?" },
    };
  });

  vars.update_clear_count = (Func<Process, bool>)((proc) => {
    vars.old_clear_count = vars.current_clear_count;

    var count = 0;
    for (int i = 0; i < vars.dreams_size; ++i) {
      var flg = proc.ReadValue<int>((IntPtr)vars.dreams_offset + 0x234 * i + 0x1c) != 0;
      vars.clear_flags[i] = flg;
      if (flg)
        ++count;
    }
    vars.current_clear_count = count;

    // changed?
    return vars.current_clear_count != vars.old_clear_count;
  });

  vars.is_cleared = (Func<Process, int, bool>)((proc, idx) => {
    // return proc.ReadValue<byte>((IntPtr)vars.dreams_offset + 0x234 * idx + 0x1c) != 0;
    return vars.clear_flags[idx];
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

  vars.starting = (Func<bool>) (() => {
    return vars.w["Starting?"].Current != 0;
  });

  vars.in_game = (Func<bool>) (() => {
    return vars.w["in Game?"].Current != 1;
  });

  vars.in_pause = (Func<bool>) (() => {
    return (vars.x["State Flags"].Current & 0x10) != 0;
  });

  vars.in_replay = (Func<bool>) (() => {
    return vars.x["in Replay?"].Current != 0;
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

  vars.update_counts = (Func<Process, bool, bool>)((proc, force) => {
    var clear_count_changed = vars.update_clear_count(proc);
    var updated = (settings["Show Counts"]
                   && vars.tcs != null
                   && (force
                       || clear_count_changed
                       || vars.w["Death Count"].Changed
                       || vars.w["Death Cancel Count"].Changed));
    if (updated) {
      // left: Clear Count
      vars.tcs.Text1 = "Clear: " + vars.current_clear_count + "/" + vars.dreams_size.ToString();
      // right: Death Count and Death Cancel Count
      vars.tcs.Text2 = ("Death Count: " + vars.w["Death Count"].Current.ToString()
                        + " (" + vars.w["Death Cancel Count"].Current.ToString() + ")");
    }
    return updated;
  });

  vars.dreams_offset = (IntPtr)current.dreams_offset;
  vars.info_offset = (IntPtr)(current.dreams_offset + 0x234 * vars.dreams_size);
  vars.w = vars.getMemoryWatcherList(game);
  vars.w.UpdateAll(game);

  vars.states_offset = (IntPtr)current.states_offset;
  vars.x = vars.getMemoryWatcherList2(game);
  vars.x.UpdateAll(game);

  vars.update_counts(game, true);
}

update
{
  if (current.dreams_offset != old.dreams_offset) {
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

  if (current.states_offset != old.states_offset) {
    vars.states_offset = (IntPtr)current.states_offset;

    print("[ASL] states_offset is changed: "
          + old.states_offset.ToString("x8")
          + " => "
          + current.states_offset.ToString("x8"));

    vars.x = vars.getMemoryWatcherList2(game);
  } else {
    vars.x.UpdateAll(game);
  }

  vars.update_counts(game, false);
}

start
{
  var res = (settings["Auto Start"]
             && vars.starting());
  if (res)
    print("[ASL] Auto Start");
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
      print("[ASL] Unknown Split Key: " + key);
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
  var res = (settings["Auto Reset"]
             && current.dreams_offset != 0
             && vars.w["Sun-1 Attempt Count"].Current == 0
             && !vars.starting()
             && !vars.in_game());
  if (res)
    print("[ASL] Auto Reset");
  return res;
}

isLoading {
  return true;
}

gameTime {
  // 1/100s => ticks
  long igt_ticks = (long)vars.w["Total Play Time"].Current * 100000;

  // Due to a bug of VD, gameTime does't work well on some dreams with dialogs.
  if (// vars.in_game() &&
      !vars.in_pause()
      && !vars.in_replay()
      && !vars.starting()
      && current.states_offset != 0) {
    long elapsed_ticks = (Stopwatch.GetTimestamp() - vars.base_time) * 10000000 / Stopwatch.Frequency;
    igt_ticks += elapsed_ticks;
  } else {
    vars.base_time = Stopwatch.GetTimestamp();
  }
  return TimeSpan.FromTicks(igt_ticks);
}

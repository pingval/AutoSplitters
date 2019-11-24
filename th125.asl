// Please move both of your "scoreth125.dat" and "bestshot" directory to other directory before "Normal" Run.

state("th125", "ver 1.00a")
{
  int unknown : 0x0b30c0;
  int st2_offset : 0xb68c8;
  int scenes_offset : 0x0b68d0;
}

startup
{
  vars.DEBUG = false;

  // Aya: Level 1-SP including SP-5~9
  vars.scenes_number_a = 108;
  vars.scene_indexes_a = new int[] { 0, 1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15, 20, 21, 22, 23, 24, 25, 26, 27, 30, 31, 32, 33, 34, 35, 36, 40, 41, 42, 43, 44, 45, 46, 47, 50, 51, 52, 53, 54, 55, 56, 57, 60, 61, 62, 63, 64, 65, 66, 70, 71, 72, 73, 74, 75, 76, 77, 80, 81, 82, 83, 84, 85, 86, 87, 90, 91, 92, 93, 94, 95, 96, 97, 100, 101, 102, 103, 104, 105, 106, 107, 110, 111, 112, 113, 114, 115, 116, 117, 120, 121, 122, 123, 124, 125, 126, 127, 128, 130, 131, 132, 133, 274, 275, 276, 277, 278, };

  // Hatate: Level 1-EX
  vars.scenes_number_h = 99;
  vars.scene_indexes_h = new int[] { 140, 141, 142, 143, 144, 145, 150, 151, 152, 153, 154, 155, 160, 161, 162, 163, 164, 165, 166, 167, 170, 171, 172, 173, 174, 175, 176, 180, 181, 182, 183, 184, 185, 186, 187, 190, 191, 192, 193, 194, 195, 196, 197, 200, 201, 202, 203, 204, 205, 206, 210, 211, 212, 213, 214, 215, 216, 217, 220, 221, 222, 223, 224, 225, 226, 227, 230, 231, 232, 233, 234, 235, 236, 237, 240, 241, 242, 243, 244, 245, 246, 247, 250, 251, 252, 253, 254, 255, 256, 257, 260, 261, 262, 263, 264, 265, 266, 267, 268, };

  vars.scenes_number_unlock_hatate = 68;

  vars.clear_flags = new bool[300];

  vars.split_nr_delay = 8;
  vars.split_et_delay = 52;

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

  // RealTime, succeed
  vars.history = new Queue<Tuple<TimeSpan, bool>>();

  vars.succeed = false;
  vars.total_attempt_count = 0;
  vars.total_success_count = 0;
  vars.history_success_count = 0;
  vars.recent_average_timespan = TimeSpan.Zero;
  vars.current_combo = 0;
  vars.max_combo = 0;

  // val, settingkey, label, tooltip, enabled, visible
  var split_defs = new List<Tuple<int, string, string, string, bool, bool>> {
    Tuple.Create(-1, "<Parent> [Normal Run]", "Normal Run", "If you uncheck this option, LiveSplit splits each time any scenes are cleared. (e.g. StB Kinkaku-ji 108 run)", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side]", "Aya's Side", "Level 1-SP with Aya (including SP-5~9)", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side]", "Hatate's Side", "Level 1-EX with Hatate", false, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 1]", "Level 1", "Aya's Level 1", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 2]", "Level 2", "Aya's Level 2", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 3]", "Level 3", "Aya's Level 3", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 4]", "Level 4", "Aya's Level 4", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 5]", "Level 5", "Aya's Level 5", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 6]", "Level 6", "Aya's Level 6", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 7]", "Level 7", "Aya's Level 7", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 8]", "Level 8", "Aya's Level 8", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 9]", "Level 9", "Aya's Level 9", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 10]", "Level 10", "Aya's Level 10", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 11]", "Level 11", "Aya's Level 11", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level 12]", "Level 12", "Aya's Level 12", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level EX]", "Level EX", "Aya's Level EX", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Aya's Side][Level SP]", "Level SP", "Aya's Level SP", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 1]", "Level 1", "Hatate's Level 1", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 2]", "Level 2", "Hatate's Level 2", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 3]", "Level 3", "Hatate's Level 3", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 4]", "Level 4", "Hatate's Level 4", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 5]", "Level 5", "Hatate's Level 5", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 6]", "Level 6", "Hatate's Level 6", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 7]", "Level 7", "Hatate's Level 7", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 8]", "Level 8", "Hatate's Level 8", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 9]", "Level 9", "Hatate's Level 9", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 10]", "Level 10", "Hatate's Level 10", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 11]", "Level 11", "Hatate's Level 11", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level 12]", "Level 12", "Hatate's Level 12", true, true),
    Tuple.Create(-1, "<Parent> [Normal Run][Hatate's Side][Level EX]", "Level EX", "Hatate's Level EX", true, true),
    Tuple.Create(0, "[Normal Run][Aya's Side][Level 1] 1-1", "1-1", "Aya's 1-1", false, true),
    Tuple.Create(1, "[Normal Run][Aya's Side][Level 1] 1-2", "1-2", "Aya's 1-2", false, true),
    Tuple.Create(2, "[Normal Run][Aya's Side][Level 1] 1-3", "1-3", "Aya's 1-3", false, true),
    Tuple.Create(3, "[Normal Run][Aya's Side][Level 1] 1-4", "1-4", "Aya's 1-4", false, true),
    Tuple.Create(4, "[Normal Run][Aya's Side][Level 1] 1-5", "1-5", "Aya's 1-5", false, true),
    Tuple.Create(5, "[Normal Run][Aya's Side][Level 1] 1-6", "1-6", "Aya's 1-6", true, true),
    Tuple.Create(10, "[Normal Run][Aya's Side][Level 2] 2-1", "2-1", "Aya's 2-1", false, true),
    Tuple.Create(11, "[Normal Run][Aya's Side][Level 2] 2-2", "2-2", "Aya's 2-2", false, true),
    Tuple.Create(12, "[Normal Run][Aya's Side][Level 2] 2-3", "2-3", "Aya's 2-3", false, true),
    Tuple.Create(13, "[Normal Run][Aya's Side][Level 2] 2-4", "2-4", "Aya's 2-4", false, true),
    Tuple.Create(14, "[Normal Run][Aya's Side][Level 2] 2-5", "2-5", "Aya's 2-5", false, true),
    Tuple.Create(15, "[Normal Run][Aya's Side][Level 2] 2-6", "2-6", "Aya's 2-6", true, true),
    Tuple.Create(20, "[Normal Run][Aya's Side][Level 3] 3-1", "3-1", "Aya's 3-1", false, true),
    Tuple.Create(21, "[Normal Run][Aya's Side][Level 3] 3-2", "3-2", "Aya's 3-2", false, true),
    Tuple.Create(22, "[Normal Run][Aya's Side][Level 3] 3-3", "3-3", "Aya's 3-3", false, true),
    Tuple.Create(23, "[Normal Run][Aya's Side][Level 3] 3-4", "3-4", "Aya's 3-4", false, true),
    Tuple.Create(24, "[Normal Run][Aya's Side][Level 3] 3-5", "3-5", "Aya's 3-5", false, true),
    Tuple.Create(25, "[Normal Run][Aya's Side][Level 3] 3-6", "3-6", "Aya's 3-6", false, true),
    Tuple.Create(26, "[Normal Run][Aya's Side][Level 3] 3-7", "3-7", "Aya's 3-7", false, true),
    Tuple.Create(27, "[Normal Run][Aya's Side][Level 3] 3-8", "3-8", "Aya's 3-8", true, true),
    Tuple.Create(30, "[Normal Run][Aya's Side][Level 4] 4-1", "4-1", "Aya's 4-1", false, true),
    Tuple.Create(31, "[Normal Run][Aya's Side][Level 4] 4-2", "4-2", "Aya's 4-2", false, true),
    Tuple.Create(32, "[Normal Run][Aya's Side][Level 4] 4-3", "4-3", "Aya's 4-3", false, true),
    Tuple.Create(33, "[Normal Run][Aya's Side][Level 4] 4-4", "4-4", "Aya's 4-4", false, true),
    Tuple.Create(34, "[Normal Run][Aya's Side][Level 4] 4-5", "4-5", "Aya's 4-5", false, true),
    Tuple.Create(35, "[Normal Run][Aya's Side][Level 4] 4-6", "4-6", "Aya's 4-6", false, true),
    Tuple.Create(36, "[Normal Run][Aya's Side][Level 4] 4-7", "4-7", "Aya's 4-7", true, true),
    Tuple.Create(40, "[Normal Run][Aya's Side][Level 5] 5-1", "5-1", "Aya's 5-1", false, true),
    Tuple.Create(41, "[Normal Run][Aya's Side][Level 5] 5-2", "5-2", "Aya's 5-2", false, true),
    Tuple.Create(42, "[Normal Run][Aya's Side][Level 5] 5-3", "5-3", "Aya's 5-3", false, true),
    Tuple.Create(43, "[Normal Run][Aya's Side][Level 5] 5-4", "5-4", "Aya's 5-4", false, true),
    Tuple.Create(44, "[Normal Run][Aya's Side][Level 5] 5-5", "5-5", "Aya's 5-5", false, true),
    Tuple.Create(45, "[Normal Run][Aya's Side][Level 5] 5-6", "5-6", "Aya's 5-6", false, true),
    Tuple.Create(46, "[Normal Run][Aya's Side][Level 5] 5-7", "5-7", "Aya's 5-7", false, true),
    Tuple.Create(47, "[Normal Run][Aya's Side][Level 5] 5-8", "5-8", "Aya's 5-8", true, true),
    Tuple.Create(50, "[Normal Run][Aya's Side][Level 6] 6-1", "6-1", "Aya's 6-1", false, true),
    Tuple.Create(51, "[Normal Run][Aya's Side][Level 6] 6-2", "6-2", "Aya's 6-2", false, true),
    Tuple.Create(52, "[Normal Run][Aya's Side][Level 6] 6-3", "6-3", "Aya's 6-3", false, true),
    Tuple.Create(53, "[Normal Run][Aya's Side][Level 6] 6-4", "6-4", "Aya's 6-4", false, true),
    Tuple.Create(54, "[Normal Run][Aya's Side][Level 6] 6-5", "6-5", "Aya's 6-5", false, true),
    Tuple.Create(55, "[Normal Run][Aya's Side][Level 6] 6-6", "6-6", "Aya's 6-6", false, true),
    Tuple.Create(56, "[Normal Run][Aya's Side][Level 6] 6-7", "6-7", "Aya's 6-7", false, true),
    Tuple.Create(57, "[Normal Run][Aya's Side][Level 6] 6-8", "6-8", "Aya's 6-8", true, true),
    Tuple.Create(60, "[Normal Run][Aya's Side][Level 7] 7-1", "7-1", "Aya's 7-1", false, true),
    Tuple.Create(61, "[Normal Run][Aya's Side][Level 7] 7-2", "7-2", "Aya's 7-2", false, true),
    Tuple.Create(62, "[Normal Run][Aya's Side][Level 7] 7-3", "7-3", "Aya's 7-3", false, true),
    Tuple.Create(63, "[Normal Run][Aya's Side][Level 7] 7-4", "7-4", "Aya's 7-4", false, true),
    Tuple.Create(64, "[Normal Run][Aya's Side][Level 7] 7-5", "7-5", "Aya's 7-5", false, true),
    Tuple.Create(65, "[Normal Run][Aya's Side][Level 7] 7-6", "7-6", "Aya's 7-6", false, true),
    Tuple.Create(66, "[Normal Run][Aya's Side][Level 7] 7-7", "7-7", "Aya's 7-7", true, true),
    Tuple.Create(70, "[Normal Run][Aya's Side][Level 8] 8-1", "8-1", "Aya's 8-1", false, true),
    Tuple.Create(71, "[Normal Run][Aya's Side][Level 8] 8-2", "8-2", "Aya's 8-2", false, true),
    Tuple.Create(72, "[Normal Run][Aya's Side][Level 8] 8-3", "8-3", "Aya's 8-3", false, true),
    Tuple.Create(73, "[Normal Run][Aya's Side][Level 8] 8-4", "8-4", "Aya's 8-4", false, true),
    Tuple.Create(74, "[Normal Run][Aya's Side][Level 8] 8-5", "8-5", "Aya's 8-5", false, true),
    Tuple.Create(75, "[Normal Run][Aya's Side][Level 8] 8-6", "8-6", "Aya's 8-6", false, true),
    Tuple.Create(76, "[Normal Run][Aya's Side][Level 8] 8-7", "8-7", "Aya's 8-7", false, true),
    Tuple.Create(77, "[Normal Run][Aya's Side][Level 8] 8-8", "8-8", "Aya's 8-8", true, true),
    Tuple.Create(80, "[Normal Run][Aya's Side][Level 9] 9-1", "9-1", "Aya's 9-1", false, true),
    Tuple.Create(81, "[Normal Run][Aya's Side][Level 9] 9-2", "9-2", "Aya's 9-2", false, true),
    Tuple.Create(82, "[Normal Run][Aya's Side][Level 9] 9-3", "9-3", "Aya's 9-3", false, true),
    Tuple.Create(83, "[Normal Run][Aya's Side][Level 9] 9-4", "9-4", "Aya's 9-4", false, true),
    Tuple.Create(84, "[Normal Run][Aya's Side][Level 9] 9-5", "9-5", "Aya's 9-5", false, true),
    Tuple.Create(85, "[Normal Run][Aya's Side][Level 9] 9-6", "9-6", "Aya's 9-6", false, true),
    Tuple.Create(86, "[Normal Run][Aya's Side][Level 9] 9-7", "9-7", "Aya's 9-7", false, true),
    Tuple.Create(87, "[Normal Run][Aya's Side][Level 9] 9-8", "9-8", "Aya's 9-8", true, true),
    Tuple.Create(90, "[Normal Run][Aya's Side][Level 10] 10-1", "10-1", "Aya's 10-1", false, true),
    Tuple.Create(91, "[Normal Run][Aya's Side][Level 10] 10-2", "10-2", "Aya's 10-2", false, true),
    Tuple.Create(92, "[Normal Run][Aya's Side][Level 10] 10-3", "10-3", "Aya's 10-3", false, true),
    Tuple.Create(93, "[Normal Run][Aya's Side][Level 10] 10-4", "10-4", "Aya's 10-4", false, true),
    Tuple.Create(94, "[Normal Run][Aya's Side][Level 10] 10-5", "10-5", "Aya's 10-5", false, true),
    Tuple.Create(95, "[Normal Run][Aya's Side][Level 10] 10-6", "10-6", "Aya's 10-6", false, true),
    Tuple.Create(96, "[Normal Run][Aya's Side][Level 10] 10-7", "10-7", "Aya's 10-7", false, true),
    Tuple.Create(97, "[Normal Run][Aya's Side][Level 10] 10-8", "10-8", "Aya's 10-8", true, true),
    Tuple.Create(100, "[Normal Run][Aya's Side][Level 11] 11-1", "11-1", "Aya's 11-1", false, true),
    Tuple.Create(101, "[Normal Run][Aya's Side][Level 11] 11-2", "11-2", "Aya's 11-2", false, true),
    Tuple.Create(102, "[Normal Run][Aya's Side][Level 11] 11-3", "11-3", "Aya's 11-3", false, true),
    Tuple.Create(103, "[Normal Run][Aya's Side][Level 11] 11-4", "11-4", "Aya's 11-4", false, true),
    Tuple.Create(104, "[Normal Run][Aya's Side][Level 11] 11-5", "11-5", "Aya's 11-5", false, true),
    Tuple.Create(105, "[Normal Run][Aya's Side][Level 11] 11-6", "11-6", "Aya's 11-6", false, true),
    Tuple.Create(106, "[Normal Run][Aya's Side][Level 11] 11-7", "11-7", "Aya's 11-7", false, true),
    Tuple.Create(107, "[Normal Run][Aya's Side][Level 11] 11-8", "11-8", "Aya's 11-8", true, true),
    Tuple.Create(110, "[Normal Run][Aya's Side][Level 12] 12-1", "12-1", "Aya's 12-1", false, true),
    Tuple.Create(111, "[Normal Run][Aya's Side][Level 12] 12-2", "12-2", "Aya's 12-2", false, true),
    Tuple.Create(112, "[Normal Run][Aya's Side][Level 12] 12-3", "12-3", "Aya's 12-3", false, true),
    Tuple.Create(113, "[Normal Run][Aya's Side][Level 12] 12-4", "12-4", "Aya's 12-4", false, true),
    Tuple.Create(114, "[Normal Run][Aya's Side][Level 12] 12-5", "12-5", "Aya's 12-5", false, true),
    Tuple.Create(115, "[Normal Run][Aya's Side][Level 12] 12-6", "12-6", "Aya's 12-6", false, true),
    Tuple.Create(116, "[Normal Run][Aya's Side][Level 12] 12-7", "12-7", "Aya's 12-7", false, true),
    Tuple.Create(117, "[Normal Run][Aya's Side][Level 12] 12-8", "12-8", "Aya's 12-8", true, true),
    Tuple.Create(120, "[Normal Run][Aya's Side][Level EX] EX-1", "EX-1", "Aya's EX-1", false, true),
    Tuple.Create(121, "[Normal Run][Aya's Side][Level EX] EX-2", "EX-2", "Aya's EX-2", false, true),
    Tuple.Create(122, "[Normal Run][Aya's Side][Level EX] EX-3", "EX-3", "Aya's EX-3", false, true),
    Tuple.Create(123, "[Normal Run][Aya's Side][Level EX] EX-4", "EX-4", "Aya's EX-4", false, true),
    Tuple.Create(124, "[Normal Run][Aya's Side][Level EX] EX-5", "EX-5", "Aya's EX-5", false, true),
    Tuple.Create(125, "[Normal Run][Aya's Side][Level EX] EX-6", "EX-6", "Aya's EX-6", false, true),
    Tuple.Create(126, "[Normal Run][Aya's Side][Level EX] EX-7", "EX-7", "Aya's EX-7", false, true),
    Tuple.Create(127, "[Normal Run][Aya's Side][Level EX] EX-8", "EX-8", "Aya's EX-8", false, true),
    Tuple.Create(128, "[Normal Run][Aya's Side][Level EX] EX-9", "EX-9", "Aya's EX-9", true, true),
    Tuple.Create(130, "[Normal Run][Aya's Side][Level SP] SP-1", "SP-1", "Aya's SP-1", false, true),
    Tuple.Create(131, "[Normal Run][Aya's Side][Level SP] SP-2", "SP-2", "Aya's SP-2", false, true),
    Tuple.Create(132, "[Normal Run][Aya's Side][Level SP] SP-3", "SP-3", "Aya's SP-3", false, true),
    Tuple.Create(133, "[Normal Run][Aya's Side][Level SP] SP-4", "SP-4", "Aya's SP-4", false, true),
    Tuple.Create(274, "[Normal Run][Aya's Side][Level SP] SP-5", "SP-5", "Hatate's SP-5", false, true),
    Tuple.Create(275, "[Normal Run][Aya's Side][Level SP] SP-6", "SP-6", "Hatate's SP-6", false, true),
    Tuple.Create(276, "[Normal Run][Aya's Side][Level SP] SP-7", "SP-7", "Hatate's SP-7", false, true),
    Tuple.Create(277, "[Normal Run][Aya's Side][Level SP] SP-8", "SP-8", "Hatate's SP-8", false, true),
    Tuple.Create(278, "[Normal Run][Aya's Side][Level SP] SP-9", "SP-9", "Hatate's SP-9", true, true),
    Tuple.Create(140, "[Normal Run][Hatate's Side][Level 1] 1-1", "1-1", "Hatate's 1-1", false, true),
    Tuple.Create(141, "[Normal Run][Hatate's Side][Level 1] 1-2", "1-2", "Hatate's 1-2", false, true),
    Tuple.Create(142, "[Normal Run][Hatate's Side][Level 1] 1-3", "1-3", "Hatate's 1-3", false, true),
    Tuple.Create(143, "[Normal Run][Hatate's Side][Level 1] 1-4", "1-4", "Hatate's 1-4", false, true),
    Tuple.Create(144, "[Normal Run][Hatate's Side][Level 1] 1-5", "1-5", "Hatate's 1-5", false, true),
    Tuple.Create(145, "[Normal Run][Hatate's Side][Level 1] 1-6", "1-6", "Hatate's 1-6", true, true),
    Tuple.Create(150, "[Normal Run][Hatate's Side][Level 2] 2-1", "2-1", "Hatate's 2-1", false, true),
    Tuple.Create(151, "[Normal Run][Hatate's Side][Level 2] 2-2", "2-2", "Hatate's 2-2", false, true),
    Tuple.Create(152, "[Normal Run][Hatate's Side][Level 2] 2-3", "2-3", "Hatate's 2-3", false, true),
    Tuple.Create(153, "[Normal Run][Hatate's Side][Level 2] 2-4", "2-4", "Hatate's 2-4", false, true),
    Tuple.Create(154, "[Normal Run][Hatate's Side][Level 2] 2-5", "2-5", "Hatate's 2-5", false, true),
    Tuple.Create(155, "[Normal Run][Hatate's Side][Level 2] 2-6", "2-6", "Hatate's 2-6", true, true),
    Tuple.Create(160, "[Normal Run][Hatate's Side][Level 3] 3-1", "3-1", "Hatate's 3-1", false, true),
    Tuple.Create(161, "[Normal Run][Hatate's Side][Level 3] 3-2", "3-2", "Hatate's 3-2", false, true),
    Tuple.Create(162, "[Normal Run][Hatate's Side][Level 3] 3-3", "3-3", "Hatate's 3-3", false, true),
    Tuple.Create(163, "[Normal Run][Hatate's Side][Level 3] 3-4", "3-4", "Hatate's 3-4", false, true),
    Tuple.Create(164, "[Normal Run][Hatate's Side][Level 3] 3-5", "3-5", "Hatate's 3-5", false, true),
    Tuple.Create(165, "[Normal Run][Hatate's Side][Level 3] 3-6", "3-6", "Hatate's 3-6", false, true),
    Tuple.Create(166, "[Normal Run][Hatate's Side][Level 3] 3-7", "3-7", "Hatate's 3-7", false, true),
    Tuple.Create(167, "[Normal Run][Hatate's Side][Level 3] 3-8", "3-8", "Hatate's 3-8", true, true),
    Tuple.Create(170, "[Normal Run][Hatate's Side][Level 4] 4-1", "4-1", "Hatate's 4-1", false, true),
    Tuple.Create(171, "[Normal Run][Hatate's Side][Level 4] 4-2", "4-2", "Hatate's 4-2", false, true),
    Tuple.Create(172, "[Normal Run][Hatate's Side][Level 4] 4-3", "4-3", "Hatate's 4-3", false, true),
    Tuple.Create(173, "[Normal Run][Hatate's Side][Level 4] 4-4", "4-4", "Hatate's 4-4", false, true),
    Tuple.Create(174, "[Normal Run][Hatate's Side][Level 4] 4-5", "4-5", "Hatate's 4-5", false, true),
    Tuple.Create(175, "[Normal Run][Hatate's Side][Level 4] 4-6", "4-6", "Hatate's 4-6", false, true),
    Tuple.Create(176, "[Normal Run][Hatate's Side][Level 4] 4-7", "4-7", "Hatate's 4-7", true, true),
    Tuple.Create(180, "[Normal Run][Hatate's Side][Level 5] 5-1", "5-1", "Hatate's 5-1", false, true),
    Tuple.Create(181, "[Normal Run][Hatate's Side][Level 5] 5-2", "5-2", "Hatate's 5-2", false, true),
    Tuple.Create(182, "[Normal Run][Hatate's Side][Level 5] 5-3", "5-3", "Hatate's 5-3", false, true),
    Tuple.Create(183, "[Normal Run][Hatate's Side][Level 5] 5-4", "5-4", "Hatate's 5-4", false, true),
    Tuple.Create(184, "[Normal Run][Hatate's Side][Level 5] 5-5", "5-5", "Hatate's 5-5", false, true),
    Tuple.Create(185, "[Normal Run][Hatate's Side][Level 5] 5-6", "5-6", "Hatate's 5-6", false, true),
    Tuple.Create(186, "[Normal Run][Hatate's Side][Level 5] 5-7", "5-7", "Hatate's 5-7", false, true),
    Tuple.Create(187, "[Normal Run][Hatate's Side][Level 5] 5-8", "5-8", "Hatate's 5-8", true, true),
    Tuple.Create(190, "[Normal Run][Hatate's Side][Level 6] 6-1", "6-1", "Hatate's 6-1", false, true),
    Tuple.Create(191, "[Normal Run][Hatate's Side][Level 6] 6-2", "6-2", "Hatate's 6-2", false, true),
    Tuple.Create(192, "[Normal Run][Hatate's Side][Level 6] 6-3", "6-3", "Hatate's 6-3", false, true),
    Tuple.Create(193, "[Normal Run][Hatate's Side][Level 6] 6-4", "6-4", "Hatate's 6-4", false, true),
    Tuple.Create(194, "[Normal Run][Hatate's Side][Level 6] 6-5", "6-5", "Hatate's 6-5", false, true),
    Tuple.Create(195, "[Normal Run][Hatate's Side][Level 6] 6-6", "6-6", "Hatate's 6-6", false, true),
    Tuple.Create(196, "[Normal Run][Hatate's Side][Level 6] 6-7", "6-7", "Hatate's 6-7", false, true),
    Tuple.Create(197, "[Normal Run][Hatate's Side][Level 6] 6-8", "6-8", "Hatate's 6-8", true, true),
    Tuple.Create(200, "[Normal Run][Hatate's Side][Level 7] 7-1", "7-1", "Hatate's 7-1", false, true),
    Tuple.Create(201, "[Normal Run][Hatate's Side][Level 7] 7-2", "7-2", "Hatate's 7-2", false, true),
    Tuple.Create(202, "[Normal Run][Hatate's Side][Level 7] 7-3", "7-3", "Hatate's 7-3", false, true),
    Tuple.Create(203, "[Normal Run][Hatate's Side][Level 7] 7-4", "7-4", "Hatate's 7-4", false, true),
    Tuple.Create(204, "[Normal Run][Hatate's Side][Level 7] 7-5", "7-5", "Hatate's 7-5", false, true),
    Tuple.Create(205, "[Normal Run][Hatate's Side][Level 7] 7-6", "7-6", "Hatate's 7-6", false, true),
    Tuple.Create(206, "[Normal Run][Hatate's Side][Level 7] 7-7", "7-7", "Hatate's 7-7", true, true),
    Tuple.Create(210, "[Normal Run][Hatate's Side][Level 8] 8-1", "8-1", "Hatate's 8-1", false, true),
    Tuple.Create(211, "[Normal Run][Hatate's Side][Level 8] 8-2", "8-2", "Hatate's 8-2", false, true),
    Tuple.Create(212, "[Normal Run][Hatate's Side][Level 8] 8-3", "8-3", "Hatate's 8-3", false, true),
    Tuple.Create(213, "[Normal Run][Hatate's Side][Level 8] 8-4", "8-4", "Hatate's 8-4", false, true),
    Tuple.Create(214, "[Normal Run][Hatate's Side][Level 8] 8-5", "8-5", "Hatate's 8-5", false, true),
    Tuple.Create(215, "[Normal Run][Hatate's Side][Level 8] 8-6", "8-6", "Hatate's 8-6", false, true),
    Tuple.Create(216, "[Normal Run][Hatate's Side][Level 8] 8-7", "8-7", "Hatate's 8-7", false, true),
    Tuple.Create(217, "[Normal Run][Hatate's Side][Level 8] 8-8", "8-8", "Hatate's 8-8", true, true),
    Tuple.Create(220, "[Normal Run][Hatate's Side][Level 9] 9-1", "9-1", "Hatate's 9-1", false, true),
    Tuple.Create(221, "[Normal Run][Hatate's Side][Level 9] 9-2", "9-2", "Hatate's 9-2", false, true),
    Tuple.Create(222, "[Normal Run][Hatate's Side][Level 9] 9-3", "9-3", "Hatate's 9-3", false, true),
    Tuple.Create(223, "[Normal Run][Hatate's Side][Level 9] 9-4", "9-4", "Hatate's 9-4", false, true),
    Tuple.Create(224, "[Normal Run][Hatate's Side][Level 9] 9-5", "9-5", "Hatate's 9-5", false, true),
    Tuple.Create(225, "[Normal Run][Hatate's Side][Level 9] 9-6", "9-6", "Hatate's 9-6", false, true),
    Tuple.Create(226, "[Normal Run][Hatate's Side][Level 9] 9-7", "9-7", "Hatate's 9-7", false, true),
    Tuple.Create(227, "[Normal Run][Hatate's Side][Level 9] 9-8", "9-8", "Hatate's 9-8", true, true),
    Tuple.Create(230, "[Normal Run][Hatate's Side][Level 10] 10-1", "10-1", "Hatate's 10-1", false, true),
    Tuple.Create(231, "[Normal Run][Hatate's Side][Level 10] 10-2", "10-2", "Hatate's 10-2", false, true),
    Tuple.Create(232, "[Normal Run][Hatate's Side][Level 10] 10-3", "10-3", "Hatate's 10-3", false, true),
    Tuple.Create(233, "[Normal Run][Hatate's Side][Level 10] 10-4", "10-4", "Hatate's 10-4", false, true),
    Tuple.Create(234, "[Normal Run][Hatate's Side][Level 10] 10-5", "10-5", "Hatate's 10-5", false, true),
    Tuple.Create(235, "[Normal Run][Hatate's Side][Level 10] 10-6", "10-6", "Hatate's 10-6", false, true),
    Tuple.Create(236, "[Normal Run][Hatate's Side][Level 10] 10-7", "10-7", "Hatate's 10-7", false, true),
    Tuple.Create(237, "[Normal Run][Hatate's Side][Level 10] 10-8", "10-8", "Hatate's 10-8", true, true),
    Tuple.Create(240, "[Normal Run][Hatate's Side][Level 11] 11-1", "11-1", "Hatate's 11-1", false, true),
    Tuple.Create(241, "[Normal Run][Hatate's Side][Level 11] 11-2", "11-2", "Hatate's 11-2", false, true),
    Tuple.Create(242, "[Normal Run][Hatate's Side][Level 11] 11-3", "11-3", "Hatate's 11-3", false, true),
    Tuple.Create(243, "[Normal Run][Hatate's Side][Level 11] 11-4", "11-4", "Hatate's 11-4", false, true),
    Tuple.Create(244, "[Normal Run][Hatate's Side][Level 11] 11-5", "11-5", "Hatate's 11-5", false, true),
    Tuple.Create(245, "[Normal Run][Hatate's Side][Level 11] 11-6", "11-6", "Hatate's 11-6", false, true),
    Tuple.Create(246, "[Normal Run][Hatate's Side][Level 11] 11-7", "11-7", "Hatate's 11-7", false, true),
    Tuple.Create(247, "[Normal Run][Hatate's Side][Level 11] 11-8", "11-8", "Hatate's 11-8", true, true),
    Tuple.Create(250, "[Normal Run][Hatate's Side][Level 12] 12-1", "12-1", "Hatate's 12-1", false, true),
    Tuple.Create(251, "[Normal Run][Hatate's Side][Level 12] 12-2", "12-2", "Hatate's 12-2", false, true),
    Tuple.Create(252, "[Normal Run][Hatate's Side][Level 12] 12-3", "12-3", "Hatate's 12-3", false, true),
    Tuple.Create(253, "[Normal Run][Hatate's Side][Level 12] 12-4", "12-4", "Hatate's 12-4", false, true),
    Tuple.Create(254, "[Normal Run][Hatate's Side][Level 12] 12-5", "12-5", "Hatate's 12-5", false, true),
    Tuple.Create(255, "[Normal Run][Hatate's Side][Level 12] 12-6", "12-6", "Hatate's 12-6", false, true),
    Tuple.Create(256, "[Normal Run][Hatate's Side][Level 12] 12-7", "12-7", "Hatate's 12-7", false, true),
    Tuple.Create(257, "[Normal Run][Hatate's Side][Level 12] 12-8", "12-8", "Hatate's 12-8", true, true),
    Tuple.Create(260, "[Normal Run][Hatate's Side][Level EX] EX-1", "EX-1", "Hatate's EX-1", false, true),
    Tuple.Create(261, "[Normal Run][Hatate's Side][Level EX] EX-2", "EX-2", "Hatate's EX-2", false, true),
    Tuple.Create(262, "[Normal Run][Hatate's Side][Level EX] EX-3", "EX-3", "Hatate's EX-3", false, true),
    Tuple.Create(263, "[Normal Run][Hatate's Side][Level EX] EX-4", "EX-4", "Hatate's EX-4", false, true),
    Tuple.Create(264, "[Normal Run][Hatate's Side][Level EX] EX-5", "EX-5", "Hatate's EX-5", false, true),
    Tuple.Create(265, "[Normal Run][Hatate's Side][Level EX] EX-6", "EX-6", "Hatate's EX-6", false, true),
    Tuple.Create(266, "[Normal Run][Hatate's Side][Level EX] EX-7", "EX-7", "Hatate's EX-7", false, true),
    Tuple.Create(267, "[Normal Run][Hatate's Side][Level EX] EX-8", "EX-8", "Hatate's EX-8", false, true),
    Tuple.Create(268, "[Normal Run][Hatate's Side][Level EX] EX-9", "EX-9", "Hatate's EX-9", true, true),
  };

  settings.Add("Show Statistics", false, "Show Statistics");
  settings.SetToolTip("Show Statistics", "Normal Run: Clear, Shot and Death Count in a Text Component.\nnot Normal Run: Success Rate, Average Time and Combo in 3 Text Components.");

  settings.Add("Unlock Hatate Run", false, "Unlock Hatate Run");
  settings.SetToolTip("Unlock Hatate Run", "The denominator of Clear Count is fixed at 68.");

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

  vars.is_cleared = (Func<Process, int, bool>)((proc, idx) => {
    // return proc.ReadValue<int>((IntPtr)vars.scenes_offset + 0x48 * idx + 0x04b4) != 0;
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

  vars.update_counts = (Func<Process, bool>)((proc) => {
    vars.old_shot_count = vars.current_shot_count;
    vars.old_clear_count = vars.current_clear_count;

    var total_clear = 0;
    var total_shot = 0;
  
    if (settings["<Parent> [Normal Run][Aya's Side]"]) {
      foreach (int idx in vars.scene_indexes_a) {
        // clear
        var flg = proc.ReadValue<int>((IntPtr)vars.scenes_offset + 0x48 * idx + 0x04b4) != 0;
        vars.clear_flags[idx] = flg;
        if (flg)
          ++total_clear;
        // shot
        var shot = proc.ReadValue<int>((IntPtr)vars.scenes_offset + 0x48 * idx + 0x049c);
        total_shot += shot;
      }
    }
    if (settings["<Parent> [Normal Run][Hatate's Side]"]) {
      foreach (int idx in vars.scene_indexes_h) {
        // clear
        var flg = proc.ReadValue<int>((IntPtr)vars.scenes_offset + 0x48 * idx + 0x04b4) != 0;
        vars.clear_flags[idx] = flg;
        if (flg)
          ++total_clear;
        // shot
        var shot = proc.ReadValue<int>((IntPtr)vars.scenes_offset + 0x48 * idx + 0x049c);
        total_shot += shot;
      }
    }
    vars.current_clear_count = total_clear;
    vars.current_shot_count = total_shot;

    // changed?
    return (vars.current_clear_count != vars.old_clear_count
            || vars.current_shot_count != vars.old_shot_count);
  });

  vars.update_statistics = (Func<Process, bool>)((proc) => {
    if (!settings["Show Statistics"]) {
      return false;
    }

    if (settings["<Parent> [Normal Run]"]) { // Normal Run
      if (vars.tcss.Count > 0) {
        // left: Clear Count
        var scenes_number = 0;
        if (settings["Unlock Hatate Run"]) {
          scenes_number = vars.scenes_number_unlock_hatate;
        } else {
          if (settings["<Parent> [Normal Run][Aya's Side]"])
            scenes_number += vars.scenes_number_a;
          if (settings["<Parent> [Normal Run][Hatate's Side]"])
            scenes_number += vars.scenes_number_h;
        }
        vars.tcss[0].Text1 = string.Format("Clear: {0:d}/{1:d}", vars.current_clear_count, scenes_number);
        // right: Shot (Death) Count
        vars.tcss[0].Text2 = string.Format("Shot (Death): {0:d} ({1:d})", vars.current_shot_count, vars.death_count);
      }
    } else {                    // not Normal Run
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

  vars.scenes_offset = (IntPtr)current.scenes_offset;
  vars.st2 = new MemoryWatcher<int>((IntPtr)current.st2_offset + 0x10);

  vars.update_counts(game);
  vars.update_statistics(game);
}

update
{
  if (current.scenes_offset != old.scenes_offset) {
    vars.scenes_offset = (IntPtr)current.scenes_offset;
  }
  if (current.st2_offset != old.st2_offset) {
    vars.st2 = new MemoryWatcher<int>((IntPtr)current.st2_offset + 0x10);
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
  // Hatate only: watch Hatate's 1-1
  var _1_1_idx = !settings["<Parent> [Normal Run][Aya's Side]"] && settings["<Parent> [Normal Run][Hatate's Side]"] ? 140 : 0;
  var not_1_1_cleared = game.ReadValue<int>((IntPtr)vars.scenes_offset + 0x48 * _1_1_idx + 0x04b4) == 0;
  var ok = ((old.unknown != 0 && current.unknown == 0)
            && (!settings["<Parent> [Normal Run]"] || not_1_1_cleared));
  // var ok = ((old.unknown != 0 && current.unknown == 0)
  //           && (!settings["<Parent> [Normal Run]"] || vars.current_clear_count == 0));

  if (ok) {
    // copy splits
    vars.splits = new Dictionary<string, int>(vars.original_splits);

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
    vars.recent_average_timespan = TimeSpan.Zero;
    vars.current_combo = 0;
    vars.max_combo = 0;

    vars.history.Clear();
    // sentinel
    vars.history.Enqueue(Tuple.Create(TimeSpan.Zero, false));

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
  if (settings["<Parent> [Normal Run]"]) { // Normal Run
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
  } else {                      // not Normal Run
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

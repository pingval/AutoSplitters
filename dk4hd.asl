// Japanese
state("DK4HD_jp", "1.0.2.0") {}

// Korean
state("DK4HD_kr", "1.0.2.0") {}

// Simplified Chinese
state("DK4HD_sc", "1.0.2.0") {}

// Traditional Chinese
state("DK4HD_tc", "1.0.2.0") {}

startup
{
  vars.DEBUG = false;

  vars.player_info_base = IntPtr.Zero;
  vars.item_info_base = IntPtr.Zero;

  vars.player_size = 0x58;
  vars.item_size = 0x40;

  // 勢力
  vars.player_indexes = new int[] { 1, 2, 4, 5, 22, 0, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20, 3, 17, 23, 18, 19, 21, };
  // 証の地図
  vars.map_of_akashi_indexes = new int[] { 155, 156, 157, 158, 159, 160, 161, };
  // 覇者の証
  vars.akashi_indexes = new int[] { 148, 149, 150, 151, 152, 153, 154, };
  // PK版覇者の証
  vars.pk_akashi_indexes = new int[] { 192, 193, 194, 195, 196, 197, 198, };

  // val, settingkey, label, tooltip, enabled, visible
  var split_defs = new List<Tuple<int, string, string, string, bool, bool>> {
    Tuple.Create(-1, "<Parent> [Akashi]", "覇者の証 (Hasha no Akashi)", "", true, true),
    Tuple.Create(-1, "<Parent> [Map of Akashi]", "証の地図 (Map of Akashi)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution]", "勢力の解散 (Dissolution of Player)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][North Sea]", "北海 (North Sea)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][Mediterranean]", "地中海 (Mediterranean)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][Africa]", "アフリカ (Africa)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][Indian Ocean]", "インド洋 (Indian Ocean)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][Southeast Asia]", "東南アジア (Southeast Asia)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][East Asia]", "東アジア (East Asia)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][New Continent]", "新大陸 (New Continent)", "", true, true),
    Tuple.Create(0, "[Akashi] North Sea", "北海 (North Sea)", "", true, true),
    Tuple.Create(1, "[Akashi] Mediterranean", "地中海 (Mediterranean)", "", true, true),
    Tuple.Create(2, "[Akashi] Africa", "アフリカ (Africa)", "", true, true),
    Tuple.Create(3, "[Akashi] Indian Ocean", "インド洋 (Indian Ocean)", "", true, true),
    Tuple.Create(4, "[Akashi] Southeast Asia", "東南アジア (Southeast Asia)", "", true, true),
    Tuple.Create(5, "[Akashi] East Asia", "東アジア (East Asia)", "", true, true),
    Tuple.Create(6, "[Akashi] New Continent", "新大陸 (New Continent)", "", true, true),
    Tuple.Create(0, "[Map of Akashi] North Sea", "北海 (North Sea)", "", false, true),
    Tuple.Create(1, "[Map of Akashi] Mediterranean", "地中海 (Mediterranean)", "", false, true),
    Tuple.Create(2, "[Map of Akashi] Africa", "アフリカ (Africa)", "", false, true),
    Tuple.Create(3, "[Map of Akashi] Indian Ocean", "インド洋 (Indian Ocean)", "", false, true),
    Tuple.Create(4, "[Map of Akashi] Southeast Asia", "東南アジア (Southeast Asia)", "", false, true),
    Tuple.Create(5, "[Map of Akashi] East Asia", "東アジア (East Asia)", "", false, true),
    Tuple.Create(6, "[Map of Akashi] New Continent", "新大陸 (New Continent)", "", false, true),
    Tuple.Create(0, "[Dissolution][North Sea] Argot Company", "アーゴット商会 (Argot Company)", "", false, true),
    Tuple.Create(1, "[Dissolution][North Sea] Bergstrom Army", "ベルグストロン軍 (Bergstrom Army)", "", false, true),
    Tuple.Create(2, "[Dissolution][North Sea] Clifford Army", "クリフォード軍 (Clifford Army)", "", false, true),
    Tuple.Create(3, "[Dissolution][North Sea] Speyer Company", "シュパイヤー商会 (Speyer Company)", "", false, true),
    Tuple.Create(4, "[Dissolution][North Sea] Truvin Corps", "トルーヴィン隊 (Truvin Corps)", "", false, true),
    Tuple.Create(5, "[Dissolution][Mediterranean] Custor Company", "カストール商会 (Custor Company)", "", false, true),
    Tuple.Create(6, "[Dissolution][Mediterranean] Albuquerque Army", "アルブケルケ軍 (Albuquerque Army)", "", false, true),
    Tuple.Create(7, "[Dissolution][Mediterranean] Valdes Army", "バルデス軍 (Valdes Army)", "", false, true),
    Tuple.Create(8, "[Dissolution][Mediterranean] Centrione Company", "チェントリオネ商会 (Centrione)", "", false, true),
    Tuple.Create(9, "[Dissolution][Mediterranean] Pasha Army", "パシャ軍 (Pasha Army)", "", false, true),
    Tuple.Create(10, "[Dissolution][Mediterranean] Hayreddin Family", "ハイレディン一家 (Hayreddin Family)", "", false, true),
    Tuple.Create(11, "[Dissolution][Africa] Sylvaira Company", "シルヴェイラ商会 (Sylvaira Company)", "", false, true),
    Tuple.Create(12, "[Dissolution][Africa] Espinosa Company", "エスピノサ商会 (Espinosa Company)", "", false, true),
    Tuple.Create(13, "[Dissolution][Indian Ocean] Woodin Company", "ウッディーン商会 (Woodin Company)", "", false, true),
    Tuple.Create(14, "[Dissolution][Indian Ocean] Nagarpur Company", "ナガルプル商会 (Nagarpur Company)", "", false, true),
    Tuple.Create(15, "[Dissolution][Southeast Asia] Pereira Company", "ペレイラ商会 (Pereira Company)", "", false, true),
    Tuple.Create(16, "[Dissolution][Southeast Asia] Kuhn Company", "クーン商会 (Kuhn Company)", "", false, true),
    Tuple.Create(17, "[Dissolution][Southeast Asia] Saiki Family", "サイキ家 (Saiki Family)", "", false, true),
    Tuple.Create(18, "[Dissolution][East Asia] Lee Family", "リー家 (Lee Family)", "", false, true),
    Tuple.Create(19, "[Dissolution][East Asia] Kurshima Family", "クルシマ家 (Kurshima Family)", "", false, true),
    Tuple.Create(20, "[Dissolution][East Asia] Korean Navy", "李朝水師 (Korean Navy)", "", false, true),
    Tuple.Create(21, "[Dissolution][New Continent] Maldonado Army", "マルドナード軍 (Maldonado Army)", "", false, true),
    Tuple.Create(22, "[Dissolution][New Continent] Escante Army", "エスカンテ軍 (Escante Army)", "", false, true),
    Tuple.Create(23, "[Dissolution][New Continent] Kunti Wayras", "クンティワイラス (Kunti Wayras)", "", false, true),
  };

  // settings.Add("Auto Start", true, "Auto Start");
  // settings.SetToolTip("Auto Start", "Start timing on SRC rules");

  // settings.Add("Auto Reset", true, "Auto Reset");
  // settings.SetToolTip("Auto Start", "Reset on New Game");

  // settings.Add("Auto Stop", true, "Auto Stop");
  // settings.SetToolTip("Auto Stop", "Stop timing on SRC rules");

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

  vars.has_map_of_akashi = (Func<Process, int, bool>)((proc, idx) => {
    int item_index = vars.map_of_akashi_indexes[idx];
    return proc.ReadValue<byte>((IntPtr)(vars.item_info_base + vars.item_size * item_index + 0x3c)) == 0x0c;
  });

  vars.has_akashi = (Func<Process, int, bool>)((proc, idx) => {
    int item_index = vars.akashi_indexes[idx];
    int pk_item_index = vars.pk_akashi_indexes[idx];
    return (proc.ReadValue<byte>((IntPtr)(vars.item_info_base + vars.item_size * item_index + 0x3c)) == 0x0e 
            || proc.ReadValue<byte>((IntPtr)(vars.item_info_base + vars.item_size * pk_item_index + 0x3c)) == 0x0e);
  });

  vars.is_player_dissolved = (Func<Process, int, bool>)((proc, idx) => {
    int player_index = vars.player_indexes[idx];
    return proc.ReadValue<byte>((IntPtr)(vars.player_info_base + vars.player_size * player_index + 0x0a)) == 0x62;
  });

  vars.timer_OnStart = (EventHandler)((s, e) => {
    // copy splits
    vars.splits = new Dictionary<string, int>(vars.original_splits);
  });
  timer.OnStart += vars.timer_OnStart;
}

init
{
  refreshRate = 60;

  // info base address
  switch (game.ProcessName.ToLower()) {
  case "dk4hd_kr":
    vars.player_info_base = (IntPtr)0x7FF7F29BA310;
    vars.item_info_base = (IntPtr)0x7FF7F29B0C00;
    break;
  case "dk4hd_sc":
    vars.player_info_base = (IntPtr)0x7FF6D07E6DB0;
    vars.item_info_base = (IntPtr)0x7FF6D07DD820;
    break;
  case "dk4hd_tc":
    vars.player_info_base = (IntPtr)0x7FF7BFA26D80;
    vars.item_info_base = (IntPtr)0x7FF7BFA1D7F0;
    break;
  default: // jp
    vars.player_info_base = (IntPtr)0x7FF7C8A491F0;
    vars.item_info_base = (IntPtr)0x7FF7C8A3FC60;
    break;
  }
  print(String.Format("[ASL] Process Name: {0}", game.ProcessName));
  print(String.Format("[ASL] Player Info Base Address: {0}", vars.player_info_base.ToString("x")));
  print(String.Format("[ASL] Item Info Base Address: {0}", vars.item_info_base.ToString("x")));
}

update
{
}

start
{
  var res = (settings["Auto Start"]
             && false);
  if (res) {
    print("[ASL] Auto Start");
  }
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
    if (key.StartsWith("[Akashi]")) {
      ok = vars.has_akashi(game, val);
    } else if (key.StartsWith("[Map of Akashi]")) {
      ok = vars.has_map_of_akashi(game, val);
    } else if (key.StartsWith("[Dissolution]")) {
      ok = vars.is_player_dissolved(game, val);
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
             && false);
  if (res)
    print("[ASL] Auto Reset");
  return res;
}

isLoading
{
  return true;
}

gameTime
{
}

shutdown
{
  timer.OnStart -= vars.timer_OnStart;
}

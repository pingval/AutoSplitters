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
  vars.char_info_base = IntPtr.Zero;
  vars.current_city = IntPtr.Zero;
  vars.prev_city = IntPtr.Zero;

  // val, settingkey, label, tooltip, enabled, visible
  var split_defs = new List<Tuple<int, string, string, string, bool, bool>> {
    Tuple.Create(-1, "<Parent> [Hasha no Akashi]", "覇者の証 (Hasha no Akashi)", "", true, true),
    Tuple.Create(-1, "<Parent> [Map of Akashi]", "証の地図 (Map of Akashi)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution]", "勢力の解散 (Dissolution of Players)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][North Sea]", "北海 (North Sea)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][Mediterranean]", "地中海 (Mediterranean)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][Africa]", "アフリカ (Africa)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][Indian Ocean]", "インド洋 (Indian Ocean)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][Southeast Asia]", "東南アジア (Southeast Asia)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][East Asia]", "東アジア (East Asia)", "", true, true),
    Tuple.Create(-1, "<Parent> [Dissolution][New Continent]", "新大陸 (New Continent)", "", true, true),
    Tuple.Create(-1, "<Parent> [Joining]", "仲間加入 (Character Joining)", "", true, true),
    Tuple.Create(-1, "<Parent> [City]", "入港 (Arrival in City)", "", true, true),
    Tuple.Create(-1, "<Parent> [City][North Sea]", "北海 (North Sea)", "", true, true),
    Tuple.Create(-1, "<Parent> [City][Mediterranean]", "地中海 (Mediterranean)", "", true, true),
    Tuple.Create(-1, "<Parent> [City][Africa]", "アフリカ (Africa)", "", true, true),
    Tuple.Create(-1, "<Parent> [City][Indian Ocean]", "インド洋 (Indian Ocean)", "", true, true),
    Tuple.Create(-1, "<Parent> [City][Southeast Asia]", "東南アジア (Southeast Asia)", "", true, true),
    Tuple.Create(-1, "<Parent> [City][East Asia]", "東アジア (East Asia)", "", true, true),
    Tuple.Create(-1, "<Parent> [City][New Continent]", "新大陸 (New Continent)", "", true, true),
    Tuple.Create(148155, "[Hasha no Akashi] North Sea", "北海 (North Sea)", "", true, true),
    Tuple.Create(149156, "[Hasha no Akashi] Mediterranean", "地中海 (Mediterranean)", "", true, true),
    Tuple.Create(150157, "[Hasha no Akashi] Africa", "アフリカ (Africa)", "", true, true),
    Tuple.Create(151158, "[Hasha no Akashi] Indian Ocean", "インド洋 (Indian Ocean)", "", true, true),
    Tuple.Create(152159, "[Hasha no Akashi] Southeast Asia", "東南アジア (Southeast Asia)", "", true, true),
    Tuple.Create(153160, "[Hasha no Akashi] East Asia", "東アジア (East Asia)", "", true, true),
    Tuple.Create(154161, "[Hasha no Akashi] New Continent", "新大陸 (New Continent)", "", true, true),
    Tuple.Create(155, "[Map of Akashi] North Sea", "北海 (North Sea)", "", false, true),
    Tuple.Create(156, "[Map of Akashi] Mediterranean", "地中海 (Mediterranean)", "", false, true),
    Tuple.Create(157, "[Map of Akashi] Africa", "アフリカ (Africa)", "", false, true),
    Tuple.Create(158, "[Map of Akashi] Indian Ocean", "インド洋 (Indian Ocean)", "", false, true),
    Tuple.Create(159, "[Map of Akashi] Southeast Asia", "東南アジア (Southeast Asia)", "", false, true),
    Tuple.Create(160, "[Map of Akashi] East Asia", "東アジア (East Asia)", "", false, true),
    Tuple.Create(161, "[Map of Akashi] New Continent", "新大陸 (New Continent)", "", false, true),
    Tuple.Create(1, "[Dissolution][North Sea] Argot Company", "アーゴット商会 (Argot Company)", "", false, true),
    Tuple.Create(2, "[Dissolution][North Sea] Bergstrom Army", "ベルグストロン軍 (Bergstrom Army)", "", false, true),
    Tuple.Create(4, "[Dissolution][North Sea] Clifford Army", "クリフォード軍 (Clifford Army)", "", false, true),
    Tuple.Create(5, "[Dissolution][North Sea] Speyer Company", "シュパイヤー商会 (Speyer Company)", "", false, true),
    Tuple.Create(22, "[Dissolution][North Sea] Truvin Corps", "トルーヴィン隊 (Truvin Corps)", "", false, true),
    Tuple.Create(0, "[Dissolution][Mediterranean] Custor Company", "カストール商会 (Custor Company)", "", false, true),
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
    Tuple.Create(20, "[Dissolution][Southeast Asia] Saiki Family", "サイキ家 (Saiki Family)", "", false, true),
    Tuple.Create(3, "[Dissolution][East Asia] Lee Family", "リー家 (Lee Family)", "", false, true),
    Tuple.Create(17, "[Dissolution][East Asia] Kurshima Family", "クルシマ家 (Kurshima Family)", "", false, true),
    Tuple.Create(23, "[Dissolution][East Asia] Korean Navy", "李朝水師 (Korean Navy)", "", false, true),
    Tuple.Create(18, "[Dissolution][New Continent] Maldonado Army", "マルドナード軍 (Maldonado Army)", "", false, true),
    Tuple.Create(19, "[Dissolution][New Continent] Escante Army", "エスカンテ軍 (Escante Army)", "", false, true),
    Tuple.Create(21, "[Dissolution][New Continent] Kunti Wayras", "クンティワイラス (Kunti Wayras)", "", false, true),
    Tuple.Create(30, "[Joining] アズィーザ・ヌレンナハール", "アズィーザ・ヌレンナハール", "", false, true),
    Tuple.Create(32, "[Joining] アミーナ・アンナフル", "アミーナ・アンナフル", "", false, true),
    Tuple.Create(20, "[Joining] アル・フェリド・シン", "アル・フェリド・シン", "", false, true),
    Tuple.Create(11, "[Joining] アルカディウス・エイレネ・エウドシオス", "アルカディウス・エイレネ・エウドシオス", "", false, true),
    Tuple.Create(18, "[Joining] アンジェロ・プッチーニ", "アンジェロ・プッチーニ", "", false, true),
    Tuple.Create(24, "[Joining] イアン・ドゥーコフ", "イアン・ドゥーコフ", "", false, true),
    Tuple.Create(28, "[Joining] イファ・ソル", "イファ・ソル", "", false, true),
    Tuple.Create(17, "[Joining] エミリオ・フェローグ", "エミリオ・フェローグ", "", false, true),
    Tuple.Create(12, "[Joining] カミル・マリヌス・オーフェルアイセル", "カミル・マリヌス・オーフェルアイセル", "", false, true),
    Tuple.Create(22, "[Joining] カルロ・シナート", "カルロ・シナート", "", false, true),
    Tuple.Create(8, "[Joining] クラウディオ・マナウス", "クラウディオ・マナウス", "", false, true),
    Tuple.Create(10, "[Joining] クリスティナ・エルネコ", "クリスティナ・エルネコ", "", false, true),
    Tuple.Create(19, "[Joining] ゲルハルト・アーデルンカッツ", "ゲルハルト・アーデルンカッツ", "", false, true),
    Tuple.Create(25, "[Joining] サムウェル・ダ・カーン", "サムウェル・ダ・カーン", "", false, true),
    Tuple.Create(37, "[Joining] シェール・アリ・ネディム", "シェール・アリ・ネディム", "", false, true),
    Tuple.Create(13, "[Joining] シエン・ヤン", "シエン・ヤン", "", false, true),
    Tuple.Create(21, "[Joining] シャルル・ジャン・ロシュフォール", "シャルル・ジャン・ロシュフォール", "", false, true),
    Tuple.Create(7, "[Joining] ジェナス・パサー", "ジェナス・パサー", "", false, true),
    Tuple.Create(14, "[Joining] ジャム・ジャック・ルドワイヤン", "ジャム・ジャック・ルドワイヤン", "", false, true),
    Tuple.Create(38, "[Joining] セシリア・デ・メルカード", "セシリア・デ・メルカード", "", false, true),
    Tuple.Create(27, "[Joining] セラ・アルトス・シャルバラーズ", "セラ・アルトス・シャルバラーズ", "", false, true),
    Tuple.Create(16, "[Joining] チェザーレ・トーニ", "チェザーレ・トーニ", "", false, true),
    Tuple.Create(33, "[Joining] ドニア・イッティハード", "ドニア・イッティハード", "", false, true),
    Tuple.Create(35, "[Joining] ハシム・アルナーディル", "ハシム・アルナーディル", "", false, true),
    Tuple.Create(34, "[Joining] ファーティマ・ハーネ", "ファーティマ・ハーネ", "", false, true),
    Tuple.Create(23, "[Joining] フェルナンド・ディアス", "フェルナンド・ディアス", "", false, true),
    Tuple.Create(9, "[Joining] フリオ・エルネコ", "フリオ・エルネコ", "", false, true),
    Tuple.Create(26, "[Joining] マヌエル・アルメイダ", "マヌエル・アルメイダ", "", false, true),
    Tuple.Create(3, "[Joining] マリア・ホアメイ・リー", "マリア・ホアメイ・リー", "", false, true),
    Tuple.Create(15, "[Joining] ユキヒサ・ゲンジョウ・シラキ", "ユキヒサ・ゲンジョウ・シラキ", "", false, true),
    Tuple.Create(29, "[Joining] ユリアン・ロペス", "ユリアン・ロペス", "", false, true),
    Tuple.Create(36, "[Joining] リョケ・シサ", "リョケ・シサ", "", false, true),
    Tuple.Create(31, "[Joining] リン・シエ", "リン・シエ", "", false, true),
    Tuple.Create(0, "[City][North Sea] ロンドン", "ロンドン", "", false, true),
    Tuple.Create(1, "[City][North Sea] ブリストル", "ブリストル", "", false, true),
    Tuple.Create(2, "[City][North Sea] アムステルダム", "アムステルダム", "", false, true),
    Tuple.Create(3, "[City][North Sea] ブルージュ", "ブルージュ", "", false, true),
    Tuple.Create(4, "[City][North Sea] ナント", "ナント", "", false, true),
    Tuple.Create(5, "[City][North Sea] ハンブルク", "ハンブルク", "", false, true),
    Tuple.Create(6, "[City][North Sea] リューベック", "リューベック", "", false, true),
    Tuple.Create(7, "[City][North Sea] ストックホルム", "ストックホルム", "", false, true),
    Tuple.Create(8, "[City][North Sea] オスロ", "オスロ", "", false, true),
    Tuple.Create(9, "[City][North Sea] コペンハーゲン", "コペンハーゲン", "", false, true),
    Tuple.Create(10, "[City][North Sea] リガ", "リガ", "", false, true),
    Tuple.Create(88, "[City][North Sea] レリースタット", "レリースタット", "", false, true),
    Tuple.Create(90, "[City][North Sea] サン＝マロ", "サン＝マロ", "", false, true),
    Tuple.Create(11, "[City][Mediterranean] リスボン", "リスボン", "", false, true),
    Tuple.Create(12, "[City][Mediterranean] セウタ", "セウタ", "", false, true),
    Tuple.Create(13, "[City][Mediterranean] セビリア", "セビリア", "", false, true),
    Tuple.Create(14, "[City][Mediterranean] バレンシア", "バレンシア", "", false, true),
    Tuple.Create(15, "[City][Mediterranean] ジェノヴァ", "ジェノヴァ", "", false, true),
    Tuple.Create(16, "[City][Mediterranean] マルセイユ", "マルセイユ", "", false, true),
    Tuple.Create(17, "[City][Mediterranean] シラクサ", "シラクサ", "", false, true),
    Tuple.Create(18, "[City][Mediterranean] ヴェネツィア", "ヴェネツィア", "", false, true),
    Tuple.Create(19, "[City][Mediterranean] アテネ", "アテネ", "", false, true),
    Tuple.Create(20, "[City][Mediterranean] クレタ", "クレタ", "", false, true),
    Tuple.Create(21, "[City][Mediterranean] キプロス", "キプロス", "", false, true),
    Tuple.Create(22, "[City][Mediterranean] イスタンブール", "イスタンブール", "", false, true),
    Tuple.Create(23, "[City][Mediterranean] ラグーサ", "ラグーサ", "", false, true),
    Tuple.Create(24, "[City][Mediterranean] ベイルート", "ベイルート", "", false, true),
    Tuple.Create(25, "[City][Mediterranean] アレキサンドリア", "アレキサンドリア", "", false, true),
    Tuple.Create(26, "[City][Mediterranean] トリポリ", "トリポリ", "", false, true),
    Tuple.Create(27, "[City][Mediterranean] アルジェ", "アルジェ", "", false, true),
    Tuple.Create(28, "[City][Mediterranean] チュニス", "チュニス", "", false, true),
    Tuple.Create(30, "[City][Mediterranean] マディラ", "マディラ", "", false, true),
    Tuple.Create(31, "[City][Mediterranean] ラスパルマス", "ラスパルマス", "", false, true),
    Tuple.Create(87, "[City][Mediterranean] アブハーズ", "アブハーズ", "", false, true),
    Tuple.Create(91, "[City][Mediterranean] ナポリ", "ナポリ", "", false, true),
    Tuple.Create(92, "[City][Mediterranean] ベンガジ", "ベンガジ", "", false, true),
    Tuple.Create(29, "[City][Africa] サン＝ジョルジェ", "サン＝ジョルジェ", "", false, true),
    Tuple.Create(32, "[City][Africa] ヴェルデ", "ヴェルデ", "", false, true),
    Tuple.Create(33, "[City][Africa] ルアンダ", "ルアンダ", "", false, true),
    Tuple.Create(34, "[City][Africa] ソファラ", "ソファラ", "", false, true),
    Tuple.Create(35, "[City][Africa] ケープタウン", "ケープタウン", "", false, true),
    Tuple.Create(36, "[City][Africa] モザンビーク", "モザンビーク", "", false, true),
    Tuple.Create(37, "[City][Africa] モガディシオ", "モガディシオ", "", false, true),
    Tuple.Create(72, "[City][Africa] シエラ＝レオネ", "シエラ＝レオネ", "", false, true),
    Tuple.Create(73, "[City][Africa] サン＝トメ", "サン＝トメ", "", false, true),
    Tuple.Create(74, "[City][Africa] マダガスカル", "マダガスカル", "", false, true),
    Tuple.Create(75, "[City][Africa] モンバサ", "モンバサ", "", false, true),
    Tuple.Create(38, "[City][Indian Ocean] バスラ", "バスラ", "", false, true),
    Tuple.Create(39, "[City][Indian Ocean] アデン", "アデン", "", false, true),
    Tuple.Create(40, "[City][Indian Ocean] マスカット", "マスカット", "", false, true),
    Tuple.Create(41, "[City][Indian Ocean] ホルムズ", "ホルムズ", "", false, true),
    Tuple.Create(42, "[City][Indian Ocean] カリカット", "カリカット", "", false, true),
    Tuple.Create(43, "[City][Indian Ocean] ゴア", "ゴア", "", false, true),
    Tuple.Create(44, "[City][Indian Ocean] セイロン", "セイロン", "", false, true),
    Tuple.Create(45, "[City][Indian Ocean] カルカッタ", "カルカッタ", "", false, true),
    Tuple.Create(46, "[City][Indian Ocean] アヴァ", "アヴァ", "", false, true),
    Tuple.Create(76, "[City][Indian Ocean] ソコトラ", "ソコトラ", "", false, true),
    Tuple.Create(77, "[City][Indian Ocean] ディヴ", "ディヴ", "", false, true),
    Tuple.Create(78, "[City][Indian Ocean] マドラス", "マドラス", "", false, true),
    Tuple.Create(79, "[City][Indian Ocean] マスリパタム", "マスリパタム", "", false, true),
    Tuple.Create(47, "[City][Southeast Asia] マラッカ", "マラッカ", "", false, true),
    Tuple.Create(48, "[City][Southeast Asia] ブルネイ", "ブルネイ", "", false, true),
    Tuple.Create(49, "[City][Southeast Asia] マニラ", "マニラ", "", false, true),
    Tuple.Create(50, "[City][Southeast Asia] バタヴィア", "バタヴィア", "", false, true),
    Tuple.Create(51, "[City][Southeast Asia] パレンバン", "パレンバン", "", false, true),
    Tuple.Create(52, "[City][Southeast Asia] テルナーテ", "テルナーテ", "", false, true),
    Tuple.Create(53, "[City][Southeast Asia] アンボイナ", "アンボイナ", "", false, true),
    Tuple.Create(80, "[City][Southeast Asia] アチン", "アチン", "", false, true),
    Tuple.Create(81, "[City][Southeast Asia] ギアデイン", "ギアデイン", "", false, true),
    Tuple.Create(82, "[City][Southeast Asia] バンジェルマシン", "バンジェルマシン", "", false, true),
    Tuple.Create(83, "[City][Southeast Asia] マカッサル", "マカッサル", "", false, true),
    Tuple.Create(84, "[City][Southeast Asia] スラバヤ", "スラバヤ", "", false, true),
    Tuple.Create(93, "[City][Southeast Asia] メナド", "メナド", "", false, true),
    Tuple.Create(54, "[City][East Asia] 杭州", "杭州", "", false, true),
    Tuple.Create(55, "[City][East Asia] 泉州", "泉州", "", false, true),
    Tuple.Create(56, "[City][East Asia] マカオ", "マカオ", "", false, true),
    Tuple.Create(57, "[City][East Asia] 漢城", "漢城", "", false, true),
    Tuple.Create(58, "[City][East Asia] 長崎", "長崎", "", false, true),
    Tuple.Create(59, "[City][East Asia] 大坂", "大坂", "", false, true),
    Tuple.Create(60, "[City][East Asia] 那覇", "那覇", "", false, true),
    Tuple.Create(85, "[City][East Asia] 沂州", "沂州", "", false, true),
    Tuple.Create(89, "[City][East Asia] 淡水", "淡水", "", false, true),
    Tuple.Create(94, "[City][East Asia] 釜山", "釜山", "", false, true),
    Tuple.Create(95, "[City][East Asia] 江戸", "江戸", "", false, true),
    Tuple.Create(61, "[City][New Continent] ハバナ", "ハバナ", "", false, true),
    Tuple.Create(62, "[City][New Continent] サント＝ドミンゴ", "サント＝ドミンゴ", "", false, true),
    Tuple.Create(63, "[City][New Continent] サン＝ファン", "サン＝ファン", "", false, true),
    Tuple.Create(64, "[City][New Continent] ジャマイカ", "ジャマイカ", "", false, true),
    Tuple.Create(65, "[City][New Continent] ヴェラクルス", "ヴェラクルス", "", false, true),
    Tuple.Create(66, "[City][New Continent] メリダ", "メリダ", "", false, true),
    Tuple.Create(67, "[City][New Continent] ポルトベロ", "ポルトベロ", "", false, true),
    Tuple.Create(68, "[City][New Continent] マラカイボ", "マラカイボ", "", false, true),
    Tuple.Create(69, "[City][New Continent] ペルナンプーゴ", "ペルナンプーゴ", "", false, true),
    Tuple.Create(70, "[City][New Continent] トルヒーヨ", "トルヒーヨ", "", false, true),
    Tuple.Create(71, "[City][New Continent] カエンヌ", "カエンヌ", "", false, true),
    Tuple.Create(86, "[City][New Continent] ペンサコラ", "ペンサコラ", "", false, true),
    Tuple.Create(96, "[City][New Continent] カラカス", "カラカス", "", false, true),
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

  // アイテムの所持(複数対応)
  vars.has_item = (Func<Process, int, bool>)((proc, _id) => {
    do {
      int id = _id % 1000;
      int val = proc.ReadValue<byte>((IntPtr)(vars.item_info_base + 0x40 * id + 0x3c));
      // 所持
      if ((val & 0x04) != 0)
        return true;

      _id /= 1000;
    } while (_id > 0);
    return false;
  });

  // 勢力の解散
  vars.is_player_dissolved = (Func<Process, int, bool>)((proc, id) => {
    return proc.ReadValue<byte>((IntPtr)(vars.player_info_base + 0x58 * id + 0x0a)) == 0x62;
  });

  // 仲間の加入
  vars.is_char_joined = (Func<Process, int, bool>)((proc, id) => {
    int hero_player_id = proc.ReadValue<byte>((IntPtr)(vars.char_info_base + 0x30 * 235 + 0x0c));
    int char_player_id = proc.ReadValue<byte>((IntPtr)(vars.char_info_base + 0x30 * id + 0x0c));
    return hero_player_id == char_player_id;
  });

  // 街へ入港
  vars.arrived_in_city = (Func<Process, int, bool>)((proc, id) => {
    int current_city_id = proc.ReadValue<byte>((IntPtr)vars.current_city);
    return current_city_id == id;
  });

  // 瀬戸内海開始
  vars.is_SetoInlandSea_started = (Func<Process, int, bool>)((proc, _) => {
    return false;
  });

  // 瀬戸内海終了
  vars.is_SetoInlandSea_ended = (Func<Process, int, bool>)((proc, _) => {
    return false;
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
    vars.char_info_base = (IntPtr)0x7FF7C8A43630;
    vars.current_city = (IntPtr)0x7FF7C8A28904;
    vars.prev_city = (IntPtr)0x7FF7C8A3D5C9;
    break;
  }
  print(String.Format("[ASL] Process Name: {0}", game.ProcessName));
  print(String.Format("[ASL] Player Info Base Address: {0}", vars.player_info_base.ToString("x")));
  print(String.Format("[ASL] Item Info Base Address: {0}", vars.item_info_base.ToString("x")));
  print(String.Format("[ASL] Char Info Base Address: {0}", vars.char_info_base.ToString("x")));
  print(String.Format("[ASL] Current City Address: {0}", vars.current_city.ToString("x")));
  print(String.Format("[ASL] Prev City Address: {0}", vars.prev_city.ToString("x")));
}

update
{
}

start
{
  // var res = (settings["Auto Start"]
  //            && false);
  // if (res) {
  //   print("[ASL] Auto Start");
  // }
  // return res;
}

split
{
  foreach (var kv in vars.splits) {
    var key = kv.Key;
    var val = kv.Value;
    if (!settings[key])
      continue;

    var ok = false;
    if (key.StartsWith("[Hasha no Akashi]")) {
      ok = vars.has_item(game, val);
    } else if (key.StartsWith("[Map of Akashi]")) {
      ok = vars.has_item(game, val);
    } else if (key.StartsWith("[Dissolution]")) {
      ok = vars.is_player_dissolved(game, val);
    } else if (key.StartsWith("[Joining]")) {
      ok = vars.is_char_joined(game, val);
    } else if (key.StartsWith("[City]")) {
      ok = vars.arrived_in_city(game, val);
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
  // var res = (settings["Auto Reset"]
  //            && false);
  // if (res)
  //   print("[ASL] Auto Reset");
  // return res;
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

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

  vars.player_info_addr = IntPtr.Zero;
  vars.item_info_addr = IntPtr.Zero;
  vars.char_info_addr = IntPtr.Zero;
  vars.current_city_addr = IntPtr.Zero;
  vars.prev_city_addr = IntPtr.Zero;
  // vars.on_sea_flag_addr = IntPtr.Zero;
  vars.scene1_addr = IntPtr.Zero;
  vars.scene2_addr = IntPtr.Zero;
  vars.bgm_addr = IntPtr.Zero;

  // タイマーストップで使用、2m25.5s
  vars.ENDING_DURATION = 145500;

  // val, settingkey, label, tooltip, enabled, visible
  var split_defs = new List<Tuple<int, string, string, string, bool, bool>> {
    Tuple.Create(0, "Auto Stop", "Auto Stop", "Stop timing on SRC rules", true, true),
    Tuple.Create(0, "Griding Starts", "瀬戸内海開始 (Griding Starts)", "prev place == Nagasaki && current place == on the sea", false, true),
    Tuple.Create(0, "Griding Ends", "瀬戸内海終了 (Griding Ends)", "hero’s level >= 100 && in city", false, true),
    Tuple.Create(-1, "<Parent> [Item]", "アイテム (Item)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Hasha no Akashi]", "覇者の証 (Hasha no Akashi)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Akashi Map]", "証の地図 (Akashi Map)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Weapon]", "武器 (Weapon)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Armor]", "防具 (Armor)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Accessory]", "装備品 (Accessory)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Tool]", "航海用品 (Tool)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Figurehead]", "船首像 (Figurehead)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Primary Product]", "原産品 (Primary Product)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Gift]", "贈り物 (Gift)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Ruins Map]", "遺跡地図 (Ruins Map)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Small Object]", "謎の小物 (Small Object)", "", true, true),
    Tuple.Create(-1, "<Parent> [Item][Keepsake]", "形見の品 (Keepsake)", "", true, true),
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
    Tuple.Create(148192, "[Item][Hasha no Akashi] North Sea", "北海 (North Sea)", "", true, true),
    Tuple.Create(149193, "[Item][Hasha no Akashi] Mediterranean", "地中海 (Mediterranean)", "", true, true),
    Tuple.Create(150194, "[Item][Hasha no Akashi] Africa", "アフリカ (Africa)", "", true, true),
    Tuple.Create(151195, "[Item][Hasha no Akashi] Indian Ocean", "インド洋 (Indian Ocean)", "", true, true),
    Tuple.Create(152196, "[Item][Hasha no Akashi] Southeast Asia", "東南アジア (Southeast Asia)", "", true, true),
    Tuple.Create(153197, "[Item][Hasha no Akashi] East Asia", "東アジア (East Asia)", "", true, true),
    Tuple.Create(154198, "[Item][Hasha no Akashi] New Continent", "新大陸 (New Continent)", "", true, true),
    Tuple.Create(155, "[Item][Akashi Map] North Sea", "北海 (North Sea)", "", false, true),
    Tuple.Create(156, "[Item][Akashi Map] Mediterranean", "地中海 (Mediterranean)", "", false, true),
    Tuple.Create(157, "[Item][Akashi Map] Africa", "アフリカ (Africa)", "", false, true),
    Tuple.Create(158, "[Item][Akashi Map] Indian Ocean", "インド洋 (Indian Ocean)", "", false, true),
    Tuple.Create(159, "[Item][Akashi Map] Southeast Asia", "東南アジア (Southeast Asia)", "", false, true),
    Tuple.Create(160, "[Item][Akashi Map] East Asia", "東アジア (East Asia)", "", false, true),
    Tuple.Create(161, "[Item][Akashi Map] New Continent", "新大陸 (New Continent)", "", false, true),
    Tuple.Create(24, "[Item][Weapon] 漆黒のレイピア", "漆黒のレイピア", "", false, true),
    Tuple.Create(25, "[Item][Weapon] ラオコーンソード", "ラオコーンソード", "", false, true),
    Tuple.Create(26, "[Item][Weapon] ローエングリンのサーベル", "ローエングリンのサーベル", "", false, true),
    Tuple.Create(27, "[Item][Weapon] 残月のショテル", "残月のショテル", "", false, true),
    Tuple.Create(28, "[Item][Weapon] 勇者のシミター", "勇者のシミター", "", false, true),
    Tuple.Create(29, "[Item][Weapon] 黄金のカットラス", "黄金のカットラス", "", false, true),
    Tuple.Create(30, "[Item][Weapon] 勇躍のベカトワ", "勇躍のベカトワ", "", false, true),
    Tuple.Create(31, "[Item][Weapon] 瑠璃色のタルワール", "瑠璃色のタルワール", "", false, true),
    Tuple.Create(32, "[Item][Weapon] 掃滅のカッツバルゲル", "掃滅のカッツバルゲル", "", false, true),
    Tuple.Create(33, "[Item][Weapon] 忠誠のフォールション", "忠誠のフォールション", "", false, true),
    Tuple.Create(34, "[Item][Weapon] 堕天使のカタール", "堕天使のカタール", "", false, true),
    Tuple.Create(35, "[Item][Weapon] 白光のフランベルジュ", "白光のフランベルジュ", "", false, true),
    Tuple.Create(36, "[Item][Weapon] 血塗られたシャムシール", "血塗られたシャムシール", "", false, true),
    Tuple.Create(37, "[Item][Weapon] ユダの魔剣", "ユダの魔剣", "", false, true),
    Tuple.Create(38, "[Item][Weapon] 趙子竜の槍", "趙子竜の槍", "", false, true),
    Tuple.Create(39, "[Item][Weapon] 償いのオルクリスト", "償いのオルクリスト", "", false, true),
    Tuple.Create(40, "[Item][Weapon] 紅毛の女海賊の宝剣", "紅毛の女海賊の宝剣", "", false, true),
    Tuple.Create(41, "[Item][Weapon] ミノタウロスの斧", "ミノタウロスの斧", "", false, true),
    Tuple.Create(42, "[Item][Weapon] なまはげの包丁", "なまはげの包丁", "", false, true),
    Tuple.Create(43, "[Item][Weapon] トラロックのナイフ", "トラロックのナイフ", "", false, true),
    Tuple.Create(44, "[Item][Weapon] ヴェパルハルバード", "ヴェパルハルバード", "", false, true),
    Tuple.Create(45, "[Item][Weapon] フビライの大剣", "フビライの大剣", "", false, true),
    Tuple.Create(46, "[Item][Weapon] アレスの聖槍", "アレスの聖槍", "", false, true),
    Tuple.Create(47, "[Item][Weapon] 聖剣エクスカリバー", "聖剣エクスカリバー", "", false, true),
    Tuple.Create(48, "[Item][Weapon] 妖刀村正", "妖刀村正", "", false, true),
    Tuple.Create(202, "[Item][Weapon] ババンギダの帯剣", "ババンギダの帯剣", "", false, true),
    Tuple.Create(203, "[Item][Weapon] 恍惚のクリスナーガ", "恍惚のクリスナーガ", "", false, true),
    Tuple.Create(204, "[Item][Weapon] 瞬殺のジャマダハル", "瞬殺のジャマダハル", "", false, true),
    Tuple.Create(211, "[Item][Weapon] 呪印剣", "呪印剣", "", false, true),
    Tuple.Create(219, "[Item][Weapon] ジガネマル", "ジガネマル", "", false, true),
    Tuple.Create(223, "[Item][Weapon] ガ・ジャルグ", "ガ・ジャルグ", "", false, true),
    Tuple.Create(49, "[Item][Armor] 蒼き樫の盾", "蒼き樫の盾", "", false, true),
    Tuple.Create(50, "[Item][Armor] アルマジロの鉄皮", "アルマジロの鉄皮", "", false, true),
    Tuple.Create(51, "[Item][Armor] シルバーサレット", "シルバーサレット", "", false, true),
    Tuple.Create(52, "[Item][Armor] 不死鳥のバシネット", "不死鳥のバシネット", "", false, true),
    Tuple.Create(53, "[Item][Armor] 巨大ゾウガメの盾", "巨大ゾウガメの盾", "", false, true),
    Tuple.Create(54, "[Item][Armor] 精霊のドレス", "精霊のドレス", "", false, true),
    Tuple.Create(55, "[Item][Armor] 刃折りの武道着", "刃折りの武道着", "", false, true),
    Tuple.Create(56, "[Item][Armor] 爽涼なる鎧", "爽涼なる鎧", "", false, true),
    Tuple.Create(57, "[Item][Armor] カネムの勇士の盾", "カネムの勇士の盾", "", false, true),
    Tuple.Create(58, "[Item][Armor] 狂信者のキュイラス", "狂信者のキュイラス", "", false, true),
    Tuple.Create(59, "[Item][Armor] 深紅のリングメイル", "深紅のリングメイル", "", false, true),
    Tuple.Create(60, "[Item][Armor] ティムールの鎖かたびら", "ティムールの鎖かたびら", "", false, true),
    Tuple.Create(61, "[Item][Armor] 孔雀かたびら", "孔雀かたびら", "", false, true),
    Tuple.Create(62, "[Item][Armor] トゥーラ戦士の兜", "トゥーラ戦士の兜", "", false, true),
    Tuple.Create(63, "[Item][Armor] 抜け忍の黒装束", "抜け忍の黒装束", "", false, true),
    Tuple.Create(64, "[Item][Armor] 琥珀色のブリガンディ", "琥珀色のブリガンディ", "", false, true),
    Tuple.Create(65, "[Item][Armor] ジャガー神の宿る胴着", "ジャガー神の宿る胴着", "", false, true),
    Tuple.Create(66, "[Item][Armor] 背徳のバンディッドメイル", "背徳のバンディッドメイル", "", false, true),
    Tuple.Create(67, "[Item][Armor] 女帝のガウン", "女帝のガウン", "", false, true),
    Tuple.Create(68, "[Item][Armor] 教経の胴丸具足", "教経の胴丸具足", "", false, true),
    Tuple.Create(69, "[Item][Armor] アッティラスーツ", "アッティラスーツ", "", false, true),
    Tuple.Create(70, "[Item][Armor] メデューサの盾", "メデューサの盾", "", false, true),
    Tuple.Create(71, "[Item][Armor] サラディンの銀の鎧", "サラディンの銀の鎧", "", false, true),
    Tuple.Create(72, "[Item][Armor] カール・マルテルの甲冑", "カール・マルテルの甲冑", "", false, true),
    Tuple.Create(73, "[Item][Armor] ミネルヴァの盾", "ミネルヴァの盾", "", false, true),
    Tuple.Create(205, "[Item][Armor] 祝福の盾", "祝福の盾", "", false, true),
    Tuple.Create(206, "[Item][Armor] 覇王の兜", "覇王の兜", "", false, true),
    Tuple.Create(207, "[Item][Armor] スキピオの鎧", "スキピオの鎧", "", false, true),
    Tuple.Create(212, "[Item][Armor] 蛇紋の石仮面", "蛇紋の石仮面", "", false, true),
    Tuple.Create(222, "[Item][Armor] プリトウェン", "プリトウェン", "", false, true),
    Tuple.Create(74, "[Item][Accessory] 魔法の革手袋", "魔法の革手袋", "", false, true),
    Tuple.Create(75, "[Item][Accessory] 精励の太綱", "精励の太綱", "", false, true),
    Tuple.Create(76, "[Item][Accessory] 天の川の星図", "天の川の星図", "", false, true),
    Tuple.Create(77, "[Item][Accessory] 星影の天球儀", "星影の天球儀", "", false, true),
    Tuple.Create(78, "[Item][Accessory] ホラティウスの詩集", "ホラティウスの詩集", "", false, true),
    Tuple.Create(79, "[Item][Accessory] 千夜一夜物語", "千夜一夜物語", "", false, true),
    Tuple.Create(80, "[Item][Accessory] 世界の駄洒落集", "世界の駄洒落集", "", false, true),
    Tuple.Create(81, "[Item][Accessory] 金のディバイダー", "金のディバイダー", "", false, true),
    Tuple.Create(82, "[Item][Accessory] 懐中時計", "懐中時計", "", false, true),
    Tuple.Create(83, "[Item][Accessory] ロッコの操船指南書", "ロッコの操船指南書", "", false, true),
    Tuple.Create(84, "[Item][Accessory] 天佑のリストバンド", "天佑のリストバンド", "", false, true),
    Tuple.Create(85, "[Item][Accessory] 善導のステッキ", "善導のステッキ", "", false, true),
    Tuple.Create(86, "[Item][Accessory] 戦士たちのオカリナ", "戦士たちのオカリナ", "", false, true),
    Tuple.Create(87, "[Item][Accessory] 大言壮語のくちばし", "大言壮語のくちばし", "", false, true),
    Tuple.Create(88, "[Item][Accessory] 東方見聞録", "東方見聞録", "", false, true),
    Tuple.Create(89, "[Item][Accessory] 陣太鼓", "陣太鼓", "", false, true),
    Tuple.Create(90, "[Item][Accessory] ポセイドンの雄叫び", "ポセイドンの雄叫び", "", false, true),
    Tuple.Create(91, "[Item][Accessory] ガリア戦記", "ガリア戦記", "", false, true),
    Tuple.Create(92, "[Item][Accessory] アレクサンダー遠征記", "アレクサンダー遠征記", "", false, true),
    Tuple.Create(93, "[Item][Accessory] 奇跡の弾丸のペンダント", "奇跡の弾丸のペンダント", "", false, true),
    Tuple.Create(94, "[Item][Accessory] 火薬精製の秘伝書", "火薬精製の秘伝書", "", false, true),
    Tuple.Create(95, "[Item][Accessory] 悪魔を貫く矢", "悪魔を貫く矢", "", false, true),
    Tuple.Create(96, "[Item][Accessory] 獅子の牙の鋸", "獅子の牙の鋸", "", false, true),
    Tuple.Create(97, "[Item][Accessory] フェイディアスの鑿", "フェイディアスの鑿", "", false, true),
    Tuple.Create(98, "[Item][Accessory] 研ぎ石いらずの鉋", "研ぎ石いらずの鉋", "", false, true),
    Tuple.Create(99, "[Item][Accessory] ヘロフィロスの医学書", "ヘロフィロスの医学書", "", false, true),
    Tuple.Create(100, "[Item][Accessory] ダヴィンチの人体解剖図", "ダヴィンチの人体解剖図", "", false, true),
    Tuple.Create(101, "[Item][Accessory] 医学典範", "医学典範", "", false, true),
    Tuple.Create(102, "[Item][Accessory] ヘスティアの釜", "ヘスティアの釜", "", false, true),
    Tuple.Create(103, "[Item][Accessory] ピンク色のエプロン", "ピンク色のエプロン", "", false, true),
    Tuple.Create(104, "[Item][Accessory] ガーゼ付きマスク", "ガーゼ付きマスク", "", false, true),
    Tuple.Create(105, "[Item][Accessory] 小粋な長靴", "小粋な長靴", "", false, true),
    Tuple.Create(106, "[Item][Accessory] グレゴリウスの冠", "グレゴリウスの冠", "", false, true),
    Tuple.Create(107, "[Item][Accessory] 絵入り聖書", "絵入り聖書", "", false, true),
    Tuple.Create(108, "[Item][Accessory] いにしえの十字架", "いにしえの十字架", "", false, true),
    Tuple.Create(109, "[Item][Accessory] 孫子の書", "孫子の書", "", false, true),
    Tuple.Create(110, "[Item][Accessory] グプタの霊獣", "グプタの霊獣", "", false, true),
    Tuple.Create(111, "[Item][Accessory] ハンニバル戦記", "ハンニバル戦記", "", false, true),
    Tuple.Create(112, "[Item][Accessory] 紀伊国屋のそろばん", "紀伊国屋のそろばん", "", false, true),
    Tuple.Create(113, "[Item][Accessory] ヴェザスの天秤", "ヴェザスの天秤", "", false, true),
    Tuple.Create(124, "[Item][Accessory] 羅針盤", "羅針盤", "", false, true),
    Tuple.Create(125, "[Item][Accessory] 六分儀", "六分儀", "", false, true),
    Tuple.Create(126, "[Item][Accessory] アリスタルコスの望遠鏡", "アリスタルコスの望遠鏡", "", false, true),
    Tuple.Create(201, "[Item][Accessory] フラミンゴの羽靴", "フラミンゴの羽靴", "", false, true),
    Tuple.Create(208, "[Item][Accessory] 獅子の瞳", "獅子の瞳", "", false, true),
    Tuple.Create(209, "[Item][Accessory] ブラックカルセドニー", "ブラックカルセドニー", "", false, true),
    Tuple.Create(210, "[Item][Accessory] ボルダーオパール", "ボルダーオパール", "", false, true),
    Tuple.Create(213, "[Item][Accessory] 古代儀式書", "古代儀式書", "", false, true),
    Tuple.Create(214, "[Item][Accessory] 金貨", "金貨", "", false, true),
    Tuple.Create(215, "[Item][Accessory] 金塊", "金塊", "", false, true),
    Tuple.Create(216, "[Item][Accessory] 海賊メダル", "海賊メダル", "", false, true),
    Tuple.Create(217, "[Item][Accessory] スターローズクォーツ", "スターローズクォーツ", "", false, true),
    Tuple.Create(218, "[Item][Accessory] ルチルインファントム", "ルチルインファントム", "", false, true),
    Tuple.Create(220, "[Item][Accessory] 魅惑と破滅の像", "魅惑と破滅の像", "", false, true),
    Tuple.Create(221, "[Item][Accessory] 竜のツノ", "竜のツノ", "", false, true),
    Tuple.Create(224, "[Item][Accessory] 純金の懐中時計", "純金の懐中時計", "", false, true),
    Tuple.Create(225, "[Item][Accessory] 真紅の指輪", "真紅の指輪", "", false, true),
    Tuple.Create(226, "[Item][Accessory] アケメネスのゴブレット", "アケメネスのゴブレット", "", false, true),
    Tuple.Create(227, "[Item][Accessory] ロゼット文フィアラ杯", "ロゼット文フィアラ杯", "", false, true),
    Tuple.Create(228, "[Item][Accessory] マドゥガ", "マドゥガ", "", false, true),
    Tuple.Create(229, "[Item][Accessory] ニアスティカ", "ニアスティカ", "", false, true),
    Tuple.Create(230, "[Item][Accessory] 惚れ薬の小瓶", "惚れ薬の小瓶", "", false, true),
    Tuple.Create(20, "[Item][Tool] 金色のネコ", "金色のネコ", "", false, true),
    Tuple.Create(21, "[Item][Tool] ライムの雫", "ライムの雫", "", false, true),
    Tuple.Create(22, "[Item][Tool] ヘルメスの祈り", "ヘルメスの祈り", "", false, true),
    Tuple.Create(23, "[Item][Tool] 華陀の漢方薬", "華陀の漢方薬", "", false, true),
    Tuple.Create(114, "[Item][Figurehead] 大鷲の像", "大鷲の像", "", false, true),
    Tuple.Create(115, "[Item][Figurehead] 子豚の像", "子豚の像", "", false, true),
    Tuple.Create(116, "[Item][Figurehead] 鯱の像", "鯱の像", "", false, true),
    Tuple.Create(117, "[Item][Figurehead] 白鯨の像", "白鯨の像", "", false, true),
    Tuple.Create(118, "[Item][Figurehead] 竜の像", "竜の像", "", false, true),
    Tuple.Create(119, "[Item][Figurehead] イルカの像", "イルカの像", "", false, true),
    Tuple.Create(120, "[Item][Figurehead] 乙女の像", "乙女の像", "", false, true),
    Tuple.Create(121, "[Item][Figurehead] 悪魔の像", "悪魔の像", "", false, true),
    Tuple.Create(122, "[Item][Figurehead] 王者の像", "王者の像", "", false, true),
    Tuple.Create(123, "[Item][Figurehead] 聖母の像", "聖母の像", "", false, true),
    Tuple.Create(199, "[Item][Figurehead] 怪魚の像", "怪魚の像", "", false, true),
    Tuple.Create(200, "[Item][Figurehead] 提督の像", "提督の像", "", false, true),
    Tuple.Create(0, "[Item][Primary Product] カボチャの種", "カボチャの種", "", false, true),
    Tuple.Create(1, "[Item][Primary Product] トマトの苗木", "トマトの苗木", "", false, true),
    Tuple.Create(2, "[Item][Primary Product] バナナの木", "バナナの木", "", false, true),
    Tuple.Create(3, "[Item][Primary Product] ミツバチの巣", "ミツバチの巣", "", false, true),
    Tuple.Create(4, "[Item][Primary Product] サメの稚魚", "サメの稚魚", "", false, true),
    Tuple.Create(5, "[Item][Primary Product] コショウの実", "コショウの実", "", false, true),
    Tuple.Create(6, "[Item][Primary Product] チョウジの実", "チョウジの実", "", false, true),
    Tuple.Create(7, "[Item][Primary Product] シナモンの木", "シナモンの木", "", false, true),
    Tuple.Create(8, "[Item][Primary Product] ピメントの実", "ピメントの実", "", false, true),
    Tuple.Create(9, "[Item][Primary Product] コーヒーの木", "コーヒーの木", "", false, true),
    Tuple.Create(10, "[Item][Primary Product] 茶の木", "茶の木", "", false, true),
    Tuple.Create(11, "[Item][Primary Product] カカオの種", "カカオの種", "", false, true),
    Tuple.Create(12, "[Item][Primary Product] タバコの苗木", "タバコの苗木", "", false, true),
    Tuple.Create(13, "[Item][Primary Product] 錬金術の書", "錬金術の書", "", false, true),
    Tuple.Create(14, "[Item][Primary Product] ガラスの製法辞典", "ガラスの製法辞典", "", false, true),
    Tuple.Create(15, "[Item][Primary Product] 蚕", "蚕", "", false, true),
    Tuple.Create(16, "[Item][Primary Product] はた織り機", "はた織り機", "", false, true),
    Tuple.Create(17, "[Item][Primary Product] アコヤガイ", "アコヤガイ", "", false, true),
    Tuple.Create(18, "[Item][Primary Product] 漢方医の聖典", "漢方医の聖典", "", false, true),
    Tuple.Create(19, "[Item][Primary Product] マンゴスチンの種", "マンゴスチンの種", "", false, true),
    Tuple.Create(127, "[Item][Gift] 凍てついたバラ", "凍てついたバラ", "", false, true),
    Tuple.Create(128, "[Item][Gift] 虹色のビー玉", "虹色のビー玉", "", false, true),
    Tuple.Create(129, "[Item][Gift] 金の砂", "金の砂", "", false, true),
    Tuple.Create(130, "[Item][Gift] パンづくりの石臼", "パンづくりの石臼", "", false, true),
    Tuple.Create(131, "[Item][Gift] 徽宗の北宋画", "徽宗の北宋画", "", false, true),
    Tuple.Create(132, "[Item][Gift] 天女のターバン", "天女のターバン", "", false, true),
    Tuple.Create(133, "[Item][Gift] サッフォーの詩集", "サッフォーの詩集", "", false, true),
    Tuple.Create(134, "[Item][Gift] 嘆きの壺", "嘆きの壺", "", false, true),
    Tuple.Create(135, "[Item][Gift] ミロのヴィーナス", "ミロのヴィーナス", "", false, true),
    Tuple.Create(136, "[Item][Gift] ステンドグラスの小花", "ステンドグラスの小花", "", false, true),
    Tuple.Create(137, "[Item][Gift] 新羅の金冠", "新羅の金冠", "", false, true),
    Tuple.Create(138, "[Item][Gift] 陶器のイヤリング", "陶器のイヤリング", "", false, true),
    Tuple.Create(139, "[Item][Gift] 翡翠の大珠", "翡翠の大珠", "", false, true),
    Tuple.Create(140, "[Item][Gift] シャクンタラー", "シャクンタラー", "", false, true),
    Tuple.Create(141, "[Item][Gift] 正倉院の水差し", "正倉院の水差し", "", false, true),
    Tuple.Create(142, "[Item][Gift] 黒瑠璃の碗", "黒瑠璃の碗", "", false, true),
    Tuple.Create(143, "[Item][Gift] 大輪の刺繍の絨毯", "大輪の刺繍の絨毯", "", false, true),
    Tuple.Create(144, "[Item][Gift] 細雪のローブ", "細雪のローブ", "", false, true),
    Tuple.Create(145, "[Item][Gift] 高麗青磁の香炉", "高麗青磁の香炉", "", false, true),
    Tuple.Create(146, "[Item][Gift] 至高のルーペ", "至高のルーペ", "", false, true),
    Tuple.Create(147, "[Item][Gift] 七色のオウム", "七色のオウム", "", false, true),
    Tuple.Create(162, "[Item][Ruins Map] 環状石柱遺跡への地図", "環状石柱遺跡への地図", "", false, true),
    Tuple.Create(163, "[Item][Ruins Map] 古代闘技場への地図", "古代闘技場への地図", "", false, true),
    Tuple.Create(164, "[Item][Ruins Map] 岩窟集落への地図", "岩窟集落への地図", "", false, true),
    Tuple.Create(165, "[Item][Ruins Map] サハラ砂漠の地図", "サハラ砂漠の地図", "", false, true),
    Tuple.Create(166, "[Item][Ruins Map] 王のモスクへの地図", "王のモスクへの地図", "", false, true),
    Tuple.Create(167, "[Item][Ruins Map] ムガル帝国の地図", "ムガル帝国の地図", "", false, true),
    Tuple.Create(168, "[Item][Ruins Map] 古代寺院への地図", "古代寺院への地図", "", false, true),
    Tuple.Create(169, "[Item][Ruins Map] 北京への地図", "北京への地図", "", false, true),
    Tuple.Create(170, "[Item][Ruins Map] 王の墓への地図", "王の墓への地図", "", false, true),
    Tuple.Create(171, "[Item][Ruins Map] 黄金の寺への地図", "黄金の寺への地図", "", false, true),
    Tuple.Create(172, "[Item][Ruins Map] 古代都市遺跡への地図", "古代都市遺跡への地図", "", false, true),
    Tuple.Create(173, "[Item][Ruins Map] アステカ王国の絵地図", "アステカ王国の絵地図", "", false, true),
    Tuple.Create(174, "[Item][Small Object] 古びた羊皮紙", "古びた羊皮紙", "", false, true),
    Tuple.Create(175, "[Item][Small Object] 模様入りの布", "模様入りの布", "", false, true),
    Tuple.Create(176, "[Item][Small Object] 謎の石版上部", "謎の石版上部", "", false, true),
    Tuple.Create(177, "[Item][Small Object] 枯れないハスの葉", "枯れないハスの葉", "", false, true),
    Tuple.Create(178, "[Item][Small Object] 古代王国の貨幣", "古代王国の貨幣", "", false, true),
    Tuple.Create(179, "[Item][Small Object] 唐代の竹細工", "唐代の竹細工", "", false, true),
    Tuple.Create(180, "[Item][Small Object] 儀式用の小刀", "儀式用の小刀", "", false, true),
    Tuple.Create(181, "[Item][Small Object] 紅色の顔料", "紅色の顔料", "", false, true),
    Tuple.Create(182, "[Item][Small Object] 真鍮のランプ", "真鍮のランプ", "", false, true),
    Tuple.Create(183, "[Item][Small Object] 謎の石版下部", "謎の石版下部", "", false, true),
    Tuple.Create(184, "[Item][Small Object] クシャナ朝の大皿", "クシャナ朝の大皿", "", false, true),
    Tuple.Create(185, "[Item][Small Object] 乳液の入った壺", "乳液の入った壺", "", false, true),
    Tuple.Create(186, "[Item][Small Object] 竹細工の組立絵図", "竹細工の組立絵図", "", false, true),
    Tuple.Create(187, "[Item][Small Object] 太陽紋の鞘", "太陽紋の鞘", "", false, true),
    Tuple.Create(188, "[Item][Keepsake] 金銅の布銭", "金銅の布銭", "", false, true),
    Tuple.Create(189, "[Item][Keepsake] ムアジンのアストロラーベ", "ムアジンのアストロラーベ", "", false, true),
    Tuple.Create(190, "[Item][Keepsake] クンビ製のポンチョ", "クンビ製のポンチョ", "", false, true),
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
    Tuple.Create(23, "[Dissolution][East Asia] Korean Navy", "朝鮮水師 (Korean Navy)", "", false, true),
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
      int val = proc.ReadValue<byte>((IntPtr)(vars.item_info_addr + 0x40 * id + 0x3c));
      // 所持
      if ((val & 0x04) != 0)
        return true;

      _id /= 1000;
    } while (_id > 0);
    return false;
  });

  // 勢力の解散
  vars.is_player_dissolved = (Func<Process, int, bool>)((proc, id) => {
    return proc.ReadValue<byte>((IntPtr)(vars.player_info_addr + 0x58 * id + 0x0a)) == 0x62;
  });

  // 仲間の加入
  vars.is_char_joined = (Func<Process, int, bool>)((proc, id) => {
    int hero_player_id = proc.ReadValue<byte>((IntPtr)(vars.char_info_addr + 0x30 * 235 + 0x0c));
    int char_player_id = proc.ReadValue<byte>((IntPtr)(vars.char_info_addr + 0x30 * id + 0x0c));
    return hero_player_id == char_player_id;
  });

  // 街へ入港
  vars.arrived_in_city = (Func<Process, int, bool>)((proc, id) => {
    int current_city_id = proc.ReadValue<byte>((IntPtr)vars.current_city_addr);
    return current_city_id == id;
  });

  // 洋上
  vars.is_on_sea = (Func<Process, bool>)((proc) => {
    // return (proc.ReadValue<byte>((IntPtr)vars.on_sea_flag_addr) & 0x08) != 0;
    // ロンドンだとうまく機能しないが……
    return proc.ReadValue<byte>((IntPtr)vars.current_city_addr) == 0;
  });

  // キャラのレベル
  vars.char_lv = (Func<Process, int, int>)((proc, id) => {
    int exp1 = proc.ReadValue<int>((IntPtr)(vars.char_info_addr + 0x30 * id + 0x18));
    int exp2 = proc.ReadValue<int>((IntPtr)(vars.char_info_addr + 0x30 * id + 0x1c));
    int lv = (int)Math.Sqrt(exp1 / 60 * 2) + (int)Math.Sqrt(exp2 / 60 * 2);
    return lv;
  });

  // 瀬戸内海開始
  vars.is_griding_started = (Func<Process, int, bool>)((proc, _) => {
    int current_city_id = proc.ReadValue<byte>((IntPtr)vars.current_city_addr);
    int prev_city_id = proc.ReadValue<byte>((IntPtr)vars.prev_city_addr);
    // 前回地 == 長崎 && 洋上
    return prev_city_id == 58 && vars.is_on_sea(proc);
  });

  // 瀬戸内海終了
  vars.is_griding_ended = (Func<Process, int, bool>)((proc, _) => {
    // 主lv100以上 && 洋上ではない
    // print(vars.char_lv(proc, 235).ToString());
    return vars.char_lv(proc, 235) >= 100 && !vars.is_on_sea(proc);
  });

  // 主人公選択画面
  vars.is_newgame_hero = (Func<Process, bool>)((proc) => {
    long scene1 = proc.ReadValue<long>((IntPtr)vars.scene1_addr);
    long scene2 = proc.ReadValue<long>((IntPtr)vars.scene2_addr);
    return scene1 == 0x0000027700000357 && scene2 == 0x000002a2000003d7;
  });

  // ニューゲーム画面
  vars.is_newgame = (Func<Process, bool>)((proc) => {
    long scene1 = proc.ReadValue<long>((IntPtr)vars.scene1_addr);
    long scene2 = proc.ReadValue<long>((IntPtr)vars.scene2_addr);
    return scene1 == 0x000002720000023e && scene2 == 0x0000029f000002c1;
  });

  // タイトル画面
  vars.title_screens = (Func<Process, bool>)((proc) => {
    int bgm = proc.ReadValue<byte>((IntPtr)vars.bgm_addr);
    return bgm == 22;
  });

  // エンディング開始
  vars.is_ending_started = (Func<Process, bool>)((proc) => {
    int bgm = proc.ReadValue<byte>((IntPtr)vars.bgm_addr);
    return bgm == 3;
  });

  vars.timer_OnStart = (EventHandler)((s, e) => {
    // copy splits
    vars.splits = new Dictionary<string, int>(vars.original_splits);
  });
  timer.OnStart += vars.timer_OnStart;

  vars.ed_sw = new Stopwatch();
}

init
{
  refreshRate = 60;

  // offsets
  int[] player_info_offsets = { 0x42CA310, 0x42B6DB0, 0x42B6D80, 0x42B91F0, };
  int[] item_info_offsets = { 0x42C0C00, 0x42AD820, 0x42AD7F0, 0x42AFC60, };
  int[] char_info_offsets = { 0x42C45D0, 0x42B11F0, 0x42B11C0, 0x42B3630, };
  int[] current_city_offsets = { 0x42A9624, 0x4296514, 0x42964E4, 0x4298904, };
  int[] prev_city_offsets = { 0x42BE569, 0x42AB189, 0x42AB159, 0x42AD5C9, };
  // int[] on_sea_flag_offsets = { 0x42BAFC8, 0x42A7BE8, 0x42A7BB8, 0x42AA028, };
  int[] scene1_offsets = { 0x42B0050, 0x429CD80, 0x429CD50, 0x429F1C0, };
  int[] scene2_offsets = { 0x42B0058, 0x429CD88, 0x429CD58, 0x429F1C8, };
  int[] bgm_offsets = { 0x42B0880, 0x429D550, 0x429D520, 0x429F990, };

  int offset_idx;
  switch (game.ProcessName.ToLower()) {
  case "dk4hd_kr":
    offset_idx = 0; break;
  case "dk4hd_sc":
    offset_idx = 1; break;
  case "dk4hd_tc":
    offset_idx = 2; break;
  default: // jp
    offset_idx = 3; break;
  }
  vars.player_info_addr = (Int64)modules.First().BaseAddress + player_info_offsets[offset_idx];
  vars.item_info_addr = (Int64)modules.First().BaseAddress + item_info_offsets[offset_idx];
  vars.char_info_addr = (Int64)modules.First().BaseAddress + char_info_offsets[offset_idx];
  vars.current_city_addr = (Int64)modules.First().BaseAddress + current_city_offsets[offset_idx];
  vars.prev_city_addr = (Int64)modules.First().BaseAddress + prev_city_offsets[offset_idx];
  // vars.on_sea_flag_addr = (Int64)modules.First().BaseAddress + on_sea_flag_offsets[offset_idx];
  vars.scene1_addr = (Int64)modules.First().BaseAddress + scene1_offsets[offset_idx];
  vars.scene2_addr = (Int64)modules.First().BaseAddress + scene2_offsets[offset_idx];
  vars.bgm_addr = (Int64)modules.First().BaseAddress + bgm_offsets[offset_idx];

  print(String.Format("[ASL] Process Name: {0}", game.ProcessName));
  print(String.Format("[ASL] BaseAddress: {0}, ModuleMemorySize: {1}", ((Int64)modules.First().BaseAddress).ToString("x"), ((Int64)modules.First().ModuleMemorySize).ToString("x")));
  print(String.Format("[ASL] Player Info Address: {0}", vars.player_info_addr.ToString("x")));
  print(String.Format("[ASL] Item Info Address: {0}", vars.item_info_addr.ToString("x")));
  print(String.Format("[ASL] Char Info Address: {0}", vars.char_info_addr.ToString("x")));
  print(String.Format("[ASL] Current City Address: {0}", vars.current_city_addr.ToString("x")));
  print(String.Format("[ASL] Prev City Address: {0}", vars.prev_city_addr.ToString("x")));
  // print(String.Format("[ASL] On-Sea Flag Address: {0}", vars.on_sea_flag_addr.ToString("x")));
  print(String.Format("[ASL] Scene#1 Address: {0}", vars.scene1_addr.ToString("x")));
  print(String.Format("[ASL] Scene#2 Address: {0}", vars.scene2_addr.ToString("x")));
  print(String.Format("[ASL] BGM Address: {0}", vars.bgm_addr.ToString("x")));
}

update
{
}

start
{
  var res = vars.is_newgame_hero(game);
  if (res)
    print("[ASL] Auto Start");
  return res;
}

split
{
  // ゲームを中断してもメモリに残る対策
  if (vars.title_screens(game))
    return;

  foreach (var kv in vars.splits) {
    var key = kv.Key;
    var val = kv.Value;
    if (!settings[key])
      continue;

    var ok = false;
    if (key.StartsWith("[Item]")) {
      ok = vars.has_item(game, val);
    } else if (key.StartsWith("[Dissolution]")) {
      ok = vars.is_player_dissolved(game, val);
    } else if (key.StartsWith("[Joining]")) {
      ok = vars.is_char_joined(game, val);
    } else if (key.StartsWith("[City]")) {
      ok = vars.arrived_in_city(game, val);
    } else if (key == "Griding Starts") {
      ok = vars.is_griding_started(game, val);
    } else if (key == "Griding Ends") {
      ok = vars.is_griding_ended(game, val);
    } else if (key == "Auto Stop") {
      if (vars.ed_sw.IsRunning) {
        ok = vars.ed_sw.ElapsedMilliseconds > vars.ENDING_DURATION;
        if (ok)
          vars.ed_sw.Reset();
      } else {
        if (vars.is_ending_started(game))
          vars.ed_sw.Restart();
      }
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
  var res = vars.is_newgame(game);
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

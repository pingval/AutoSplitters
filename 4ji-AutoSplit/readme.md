# AutoSplitの使い方

1. Flash Player Projectorにyojijuku.swfをD&Dし四字熟語Flashを起動する。
2. AutoSplitを起動し、setting.pngのように設定する。
  - Split Image Folderには圧縮ファイル内の4jiフォルダを指定する。
  - FPS Limitにはなるべく大きい値を入れるといいと思う。
  - Timer Global Hotkeyの「Start / Split」と「Reset」にはLiveSplitに設定してあるショートカットキーを指定する。
    - 注意: 「Shift+何か」のような複数のキーの組み合わせは設定できない！
  - Loop Split Imagesにチェックを入れておくと繰り返し走る場合に便利。
  - 「Select Window」ボタンを押し、Flash Player Projectorを選択する。
  - XとYには、
    - Flash Player Projectorのクライアント領域サイズがデフォルトの560x420の場合、X:520, Y:51と入力する。
    - 640x480かつ表示100%の場合(自分)、X:560, Y:81と入力する。
  - Widthには48、Heightには420を入力する。
    - region.pngで示す範囲がキャプチャできていればよい。
3. LiveSplitを起動する。AutoSplitの「Start Auto Splitter」ボタンを押して画像認識を動かし、実際に走る。
  - 完走後にまた走る場合はLiveSplitのStart/Splitキーを押すだけでよい。
  - 途中でリセットして最初から走り直したい場合、LiveSplitをResetし、かつAutoSplitの「Reset」ボタンと「Start Auto Splitter」ボタンを押す。

## その他

- 最後のSplitは画面表示後に0.25sの遅延をかけている。遅延が変に感じる場合はファイル名「090_stop_(1.0)_[1]_#0250#.png」の「#0250#」の部分を変更して調整してね。
- 7面クリア直後のSplitが邪魔なら「080_Stage7_(1.0)_[1].png」を削除してね。

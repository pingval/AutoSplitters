# Auto Splitters

[LiveSplit/Documentation/Auto-Splitters.md](https://github.com/LiveSplit/LiveSplit/blob/master/Documentation/Auto-Splitters.md)の日本語訳です。

<!-- TOC depthFrom:2 depthTo:4 orderedList:false updateOnSave:true withLinks:true -->

- [Auto Splitterの機能 (Features of an Auto Splitter)](#auto-splitterの機能-features-of-an-auto-splitter)
  - [ゲームタイム (Game Time)](#ゲームタイム-game-time)
  - [自動スプリット (Automatic Splits)](#自動スプリット-automatic-splits)
  - [タイマーの自動スタート (Automatic Timer Start)](#タイマーの自動スタート-automatic-timer-start)
  - [自動リセット (Automatic Resets)](#自動リセット-automatic-resets)
- [Auto Splitterの仕組み (How an Auto Splitter works)](#auto-splitterの仕組み-how-an-auto-splitter-works)
  - [ポインタパス (Pointer Paths)](#ポインタパス-pointer-paths)
- [The Auto Splitting Language - ASL](#the-auto-splitting-language---asl)
  - [状態記述子 (State Descriptors)](#状態記述子-state-descriptors)
    - [状態オブジェクト (State objects)](#状態オブジェクト-state-objects)
  - [アクション (Actions)](#アクション-actions)
    - [タイマー制御 (Timer Control)](#タイマー制御-timer-control)
    - [スクリプト管理 (Script Management)](#スクリプト管理-script-management)
  - [アクション変数 (Action Variables)](#アクション変数-action-variables)
    - [一般的な変数 (General Variables)](#一般的な変数-general-variables)
    - [ゲーム依存 (Game Dependent)](#ゲーム依存-game-dependent)
  - [設定 (Settings)](#設定-settings)
    - [基本設定 (Basic Settings)](#基本設定-basic-settings)
    - [カスタム設定 (Custom Settings)](#カスタム設定-custom-settings)
  - [ビルトイン関数 (Built-in Functions)](#ビルトイン関数-built-in-functions)
  - [スクリプトのテスト (Testing your Script)](#スクリプトのテスト-testing-your-script)
    - [デバッグ (Debugging)](#デバッグ-debugging)
- [Auto Splitterの追加 (Adding an Auto Splitter)](#auto-splitterの追加-adding-an-auto-splitter)
- [資料 (Additional Resources)](#資料-additional-resources)

<!-- /TOC -->

<!-- TOC depth:6 withLinks:1 updateOnSave:1 orderedList:0 -->

<!--
- [Features of an Auto Splitter](#features-of-an-auto-splitter)
	- [Game Time](#game-time)
	- [Automatic Splits](#automatic-splits)
	- [Automatic Timer Start](#automatic-timer-start)
	- [Automatic Resets](#automatic-resets)
- [How an Auto Splitter works](#how-an-auto-splitter-works)
	- [Pointer Paths](#pointer-paths)
- [The Auto Splitting Language - ASL](#the-auto-splitting-language---asl)
	- [State Descriptors](#state-descriptors)
		- [State objects](#state-objects)
	- [Actions](#actions)
		- [Timer Control](#timer-control)
		- [Script Management](#script-management)
	- [Action Variables](#action-variables)
		- [General Variables](#general-variables)
		- [Game Dependent](#game-dependent)
	- [Settings](#settings-1)
		- [Basic Settings](#basic-settings)
		- [Custom Settings](#custom-settings)
	- [Built-in Functions](#built-in-functions)
	- [Testing your Script](#testing-your-script)
		- [Debugging](#debugging)
- [Adding an Auto Splitter](#adding-an-auto-splitter)
- [Additional Resources](#additional-resources)
-->

<!-- /TOC -->

<!--
LiveSplit has integrated support for Auto Splitters. An Auto Splitter can be one of the following:
-->
LiveSplitはAuto Splittersのサポートを統合しました。次のいずれかが、Auto Splitterになります:
<!--
 * A Script written in the Auto Splitting Language (ASL).
 * A LiveSplit Component written in any .NET compatible language.
 * A third party application communicating with LiveSplit through the LiveSplit  Server.
-->
 * Auto Splitting Language (ASL)で書かれたスクリプト
 * .NET互換言語で書かれたLiveSplitコンポーネント
 * LiveSplitサーバを介してLiveSplitと通信するサードパーティ製アプリケーション

<!--
At the moment LiveSplit can automatically download and activate Auto Splitters that are LiveSplit Components or ASL Scripts. Support for applications using the LiveSplit Server is planned, but is not yet available.
-->
現在LiveSplitは、Auto Splitters(LiveSplitコンポーネントまたはASLスクリプト)の自動ダウンロードとアクティブ化が可能です。LiveSplit Serverを使ったアプリケーションのサポートは計画はされていますが、まだ利用できません。

<!-- ## Features of an Auto Splitter -->
## Auto Splitterの機能 (Features of an Auto Splitter)

<!--
An Auto Splitter can provide any of the following features:
-->
Auto Splitterは、以下の機能をすべて提供できます。

<!-- ### Game Time -->
### ゲームタイム (Game Time)

<!--
Game Time can either be Real Time without Loads or an actual Game Timer found in the game. This depends on the game and the speedrun community of that game. If the game has been run in Real Time for multiple years already, introducing a new timing method might not be worth it.
-->
ゲームタイムとは、ロード時間を除くリアルタイム、またはゲーム内で見つかる実際のゲームタイマーのどちらかです。どちらであるかは、そのゲームとスピードランコミュニティ次第です。ゲームがすでに数年にわたってリアルタイムで走られている場合、新しいタイミング方法の導入には価値がないかもしれません。

<!-- ### Automatic Splits -->
### 自動スプリット (Automatic Splits)

<!--
An Auto Splitter, as the name suggests, can also provide automatic splits to increase the accuracy of the individual segment and split times. An Auto Splitter might not necessarily implement Automatic Splits for every single split available since the runner might want to have some additional splits that are not supported by the Auto Splitter used.
-->
Auto Splitterはその名の通り、個々のセグメントやスプリットタイムの精度を上げるための自動スプリットを提供できます。使用されているAuto Splitterでサポートされないスプリットの追加を走者が希望する可能性があるため、Auto Splitterは必ずしも利用可能なすべてのスプリットについてオートスプリットを実装するとは限りません。

<!-- ### Automatic Timer Start -->
### タイマーの自動スタート (Automatic Timer Start)

<!--
Not every Auto Splitter automatically starts the timer. For some games, the Auto Splitter can't tell whether the runner just wants to start the game to practice something or actually wants to do a run.
-->
すべてのAuto Splitterが自動的にタイマーを開始するわけではありません。一部のゲームでは、走者が練習のためにゲームを開始するだけなのか、それとも実際に走りたいのかをAuto Splitterは区別できません。

<!-- ### Automatic Resets -->
### 自動リセット (Automatic Resets)

<!--
An Auto Splitter can automatically reset the timer. This might be useful for games where going back to the main menu always means that the run is over. This is a bit dangerous though, as the runner might not have wanted to reset there. Think twice before implementing this functionality into your Auto Splitter.
-->
Auto Splitterはタイマーの自動リセットができます。これは、メインメニューに戻ることがRTAの終了を常に意味するゲームには役に立つかもしれません。しかし走者がそこでリセットしたくないかもしれないので、これは少し危険ではあります。この機能をAuto Splitterに組み込む前に、よく考えてください。

<!-- ## How an Auto Splitter works -->
## Auto Splitterの仕組み (How an Auto Splitter works)

<!--
Auto Splitters can work in one or multiple of the following ways:
-->
Auto Splittersには、以下の機能があります。
<!--
 * It can read the RAM, interpret the values, and toggle any of the actions described above based on these values. The RAM addresses might not always be the same. Therefore, the Auto Splitter might need to follow a so called *Pointer Path*. This is what most Auto Splitters do and what is directly supported by the Auto Splitting Language.
 * It can scan the game's RAM to find a value and toggle any of the actions based on these values. Doing a memory scan is slower than following a Pointer Path.
 * It can read the game's log files, parse them, and toggle actions based on those. This works, but is usually fairly delayed, which is why this isn't that great of a solution.
 * It can read the game's standard output stream. This only works if the game actually writes valuable information to the standard output, which is rare. Also, Steam prevents this method since in order to read the standard output, you need to start the game's process through the Auto Splitter, which Steam won't let you do.
-->
 * RAMを読み取って値を解釈し、その値に基づいて上記のアクションを切り替えることができます。RAMアドレスは常に同じとは限りません。したがって、Auto Splitterはいわゆる*ポインタパス*の追跡を要する場合があります。これはほとんどのAuto Splittersの行っていることであり、Auto Splitting Languageによって直接サポートされています。
 * ゲームのRAMをスキャンして値を見つけ、その値に基づいてアクションを切り替えることができます。メモリスキャンの実行は、ポインタパスをたどるよりも時間がかかります。
 * ゲームのログファイルを読み、解析し、それに基づいてアクションを切り替えることができます。これは通常はかなり遅いため、あまり良い解決策ではありません。
 * ゲームの標準出力ストリームを読むことができます。これは、ゲームが貴重な情報を標準出力へ出力する場合にのみ機能します。これは稀です。また、標準出力を読み取るSteamにはこの方法は阻まれます。ゲームのプロセスをAuto Splitterを通して開始する必要がありますが、Steamに阻まれるでしょう。

<!-- ### Pointer Paths -->
### ポインタパス (Pointer Paths)

<!--
A Pointer Path is a list of Offsets + a Base Address. The Auto Splitter reads the value at the base address and interprets the value as yet another address. It adds the first offset to this address and reads the value of the calculated address. It does this over and over until there are no more offsets. At that point, it has found the value it was searching for. This resembles the way objects are stored in memory. Every object has a clearly defined layout where each variable has a consistent offset within the object, so you basically follow these variables from object to object.
-->
ポインタパスとは、オフセットのリスト + ベースアドレスのことです。Auto Splitterはベースアドレスにある値を読み取り、その値をさらに別のアドレスとして解釈します。このアドレスに最初のオフセットを加算し、計算されたアドレスにある値を読み取ります。これを繰り返し、オフセットがなくなった時点で値の検索が終了します。これは、オブジェクトがメモリに格納される方法と似ています。各オブジェクトは明確に定義されたレイアウトを持ち、各変数はオブジェクト内で一貫したオフセットを持っています。したがって、これらの変数はオブジェクトからオブジェクトへと辿ることが基本的に可能です。

<!--
*Cheat Engine* is a tool that allows you to easily find Addresses and Pointer Paths for those Addresses, so you don't need to debug the game to figure out the structure of the memory.
-->
*Cheat Engine*という、アドレスと、そのアドレスに至るポインタパスを簡単に見つけるツールがあります。なのでメモリの構造を解明するためにゲームをデバッグする必要はありません。

<!-- ## The Auto Splitting Language - ASL -->
## The Auto Splitting Language - ASL

<!--
The Auto Splitting Language is a small scripting language made specifically for LiveSplit Auto Splitters. It has a few advantages and disadvantages over normal Components.
-->
ASLとは、LiveSplit Auto Splitters専用に作られた、小規模なスクリプト言語です。通常のコンポーネントと比べると、多少の長所短所があります。

<!--
**Advantages:**
-->
**長所**:
<!--
 * ASL Scripts are easy to maintain.
 * There's no need to update the Script for new LiveSplit versions.
 * No Visual Studio or any compiler is needed; you can write it in Notepad.
-->
 * ASLスクリプトは保守が容易です。
 * LiveSplitの新バージョン用にスクリプトを更新する必要はありません。
 * Visual Studioなどのコンパイラは不要であり、メモ帳で書くことができます。

<!--
**Disadvantages:**
-->
**短所**:
<!--
 * Currently only provides Boolean settings in the GUI for the user to change.
-->
 * 現在のところ、ユーザーの変更できるGUIでは真偽値しか設定できません。

<!--
An ASL Script contains a State Descriptor and multiple [Actions](#actions) which contain C# code.
-->
ASLスクリプトは、状態記述子と、C#コードを含む複数の[アクション](#actions)を内包しています。

<!-- ### State Descriptors -->
### 状態記述子 (State Descriptors)

<!--
The State Descriptor is the most important part of the script and describes which game process and which state of the game the script is interested in. This is where all of the Pointer Paths, which the Auto Splitter uses to read values from the game, are described. A State Descriptor looks like this:
-->
状態記述子はスクリプトの最も重要な部分であり、ゲームのプロセスと、スクリプトが関与するゲームの状態を記述します。ここには、Auto Splitterがゲームから値を読み取るために使用するポインタパスが全て記述されています。状態記述子はこのようなものです:
<!--
```
state("PROCESS_NAME")
{
	POINTER_PATH
	POINTER_PATH
	...
}
```
-->
```
state("PROCESS_NAME")
{
	POINTER_PATH
	POINTER_PATH
	...
}
```

<!--
If the script needs to support multiple versions of the game, you can specify an optional version identifier:
-->
ゲームの複数のバージョンにスクリプトを対応させる必要がある場合は、バージョン識別子オプションを指定できます:
<!--
```
state("PROCESS_NAME", "VERSION_IDENTIFIER")
...
```
-->
```
state("PROCESS_NAME", "VERSION_IDENTIFIER")
...
```

<!--
The `PROCESS_NAME` is the name of the process the Auto Splitter should look for. The Script is inactive while it's not connected to a process. Once a process with that name is found, it automatically connects to that process. A Process Name should not include the `.exe`. Even advanced scripts that use other ways to access the game's memory require a State Descriptor to define which process LiveSplit is supposed to connect to.
-->
`PROCESS_NAME`はAuto Splitterが探すべきプロセスの名前です。スクリプトはプロセスに接続されていない間は非アクティブです。その名前のプロセスが見つかると、自動的にそのプロセスに接続します。プロセス名は`.exe`を含んではいけません。別の方法でゲームのメモリにアクセスする高度なスクリプトでも、LiveSplitが接続するプロセスを定義するために状態記述子は必須です。

<!--
The optional `VERSION_IDENTIFIER` can be any arbitrary string you wish to use. Note that the script can define multiple State Descriptors for different processes/games. These optional features are extremely useful for emulators.
-->
オプションの`VERSION_IDENTIFIER`には任意の文字列が使えます。スクリプトは異なるプロセス/ゲームに対して複数の状態記述子を定義できることに注意してください。これらのオプション機能はエミュレータにとって非常に便利です。

<!--
`POINTER_PATH` describes a Pointer Path and has two ways to declare:
-->
`POINTER_PATH`にはポインタパスを記述します。宣言する方法は2つあります:
<!--
```
VARIABLE_TYPE VARIABLE_NAME : OFFSET, OFFSET, OFFSET, ...;
VARIABLE_TYPE VARIABLE_NAME : "BASE_MODULE", OFFSET, OFFSET, OFFSET, ...;
```
-->
```
VARIABLE_TYPE VARIABLE_NAME : OFFSET, OFFSET, OFFSET, ...;
VARIABLE_TYPE VARIABLE_NAME : "BASE_MODULE", OFFSET, OFFSET, OFFSET, ...;
```

<!--
The variable type `VARIABLE_TYPE` describes the type of the value found at the pointer path. It can be one of the following:
-->
変数の型`VARIABLE_TYPE`はポインタパスで見つけた値の型を表します。次のいずれかになります:

<!--
| Type             | Description                |
|------------------|----------------------------|
| sbyte            | Signed 8-bit integer       |
| byte             | Unsigned 8-bit integer     |
| short            | Signed 16-bit integer      |
| ushort           | Unsigned 16-bit integer    |
| int              | Signed 32-bit integer      |
| uint             | Unsigned 32-bit integer    |
| long             | Signed 64-bit integer      |
| ulong            | Unsigned 64-bit integer    |
| float            | 32-bit IEEE floating-point |
| double           | 64-bit IEEE floating-point |
| bool             | Boolean                    |
| string\<length\> | String (e.g. string255)    |
| byte\<length\>   | Byte array (e.g. byte255)  |
-->

| 型               | 説明                        |
|------------------|----------------------------|
| sbyte            | 符号付き8ビット整数          |
| byte             | 符号なし8ビット整数          |
| short            | 符号付き16ビット整数         |
| ushort           | 符号なし16ビット整数         |
| int              | 符号付き32ビット整数         |
| uint             | 符号なし32ビット整数         |
| long             | 符号付き64ビット整数         |
| ulong            | 符号なし64ビット整数         |
| float            | IEEE 単精度浮動小数点数      |
| double           | IEEE 倍精度浮動小数点数      |
| bool             | ブール値                    |
| string\<length\> | 文字列 (e.g. string255)     |
| byte\<length\>   | byte配列 (e.g. byte255)     |

<!--
The variable name `VARIABLE_NAME` can be any variable name you choose, describing what is found at the pointer path. The naming is up to you, but should be distinct from the other variable names.
-->
変数名`VARIABLE_NAME`には任意の名称を選択でき、ポインタパスに何が見つかるかを記述したものです。命名はあなた次第ですが、他の変数名とは区別できるようにすべきでしょう。

<!--
The optional base module name `BASE_MODULE` describes the name of the module the Pointer Path starts at. Every \*.exe and \*.dll file loaded into the process has its own base address. Instead of specifying the base address of the Pointer Path, you specify the base module and an offset from there. If this is not defined, it will default to the main (.exe) module.
-->
オプションのベースモジュール名`BASE_MODULE`には、ポインタパスが始まるモジュールの名前を記述します。プロセスにロードされるすべての\*.exeファイルおよび\*.dllファイルには、それぞれ固有のベースアドレスがあります。ポインタパスのベースアドレスを指定する代わりに、ベースモジュールとそこからのオフセットを指定します。これが定義されていない場合は、デフォルトでメイン(.exe)モジュールになります。

<!--
You can use as many offsets `OFFSET` as you want. They need to be integer literals, either written as decimal or hexadecimal.
-->
オフセット`OFFSET`はいくらでも使うことができます。これは10進数または16進数で書かれた整数リテラルである必要があります。

<!-- #### State objects -->
#### 状態オブジェクト (State objects)

<!--
The State Variables described through the State Descriptor are available through two State objects: `current` and `old`. The `current` object contains the current state of the game with all the up-to-date variables, while the `old` object contains the state of the variables at the last execution of the ASL Script in LiveSplit. These objects are useful for checking for state changes. For example, you could check if the last level of a game was a certain value and is now a certain other value, which might mean that a split needs to happen.
-->
状態記述子を通して記述された状態変数は、`current`と` old`という二つの状態オブジェクトを通して利用可能です。`current`オブジェクトにはすべての最新の変数を含む、ゲームの現在の状態が入っており、` old`オブジェクトにはLiveSplitのASLスクリプトが直前に実行された時の変数の状態が入っています。これらのオブジェクトは状態の変化をチェックするのに役立ちます。たとえば、ゲームの直前のレベルがある値で、現在はある別の値になっているかどうかをチェックできます。これは、スプリットの実行の必要があることを意味する場合があります。

<!--
LiveSplit's internal state is also available through the object `timer`. This is an object of the type [`LiveSplitState`](../LiveSplit/LiveSplit.Core/Model/LiveSplitState.cs) and can be used to interact with LiveSplit in ways that are not directly available through ASL.
-->
LiveSplitの内部状態は`timer`オブジェクトを通しても利用可能です。これは[`LiveSplitState`](https://github.com/LiveSplit/LiveSplit/blob/master/LiveSplit/LiveSplit.Core/Model/LiveSplitState.cs)型のオブジェクトで、ASLから直接利用できない方法でLiveSplitとやり取りするために使用できます。

<!-- ### Actions -->
### アクション (Actions)

<!--
After writing a State Descriptor, you can implement multiple actions such as splitting and starting the timer. These actions define the logic of the Auto Splitter based on the information described by the State Descriptor. An action looks like this:
-->
状態記述子を書いた後は、タイマーのスプリットやスタートなどの複数のアクションを実装できます。これらのアクションは、状態記述子に記述された情報に基づいて自動スプリットのロジックを定義します。アクションは次のようになります。
<!--
```
ACTION_NAME
{
	C# CODE
}
```
-->
```
ACTION_NAME
{
	C# CODE
}
```

<!--
You can think of Actions like functions that are automatically called by the ASL Component. These functions can only interact with eachother or LiveSplit via the [special variables](#action-variables) the environment provides.
-->
アクションは、ASLコンポーネントによって自動的に呼び出される関数のように考えることができます。これらの関数は、環境が提供する[特殊な変数](#アクション変数-action-variables)を介してのみ、相互にまたはLiveSplitとやり取りできます。

<!--
All of the actions are optional and are declared by their name `ACTION_NAME` followed by a code block `CODE`. You trigger the action by returning a value. Returning a value is optional though; if no value is returned, the action is not triggered. Some actions are only executed while LiveSplit is connected to the process.
-->
すべてのアクションはオプションであり、名前`ACTION_NAME`とそれに続くコードブロック`CODE`によって宣言されます。値を返すことで、アクションは発動されます。ただし、値を返すことはオプションです。値が返されない場合、アクションは発動されません。LiveSplitがプロセスに接続されている間にのみ実行されるアクションもあります。

<!--
Actions are implemented in C#. You can use C#'s documentation for any questions you may have regarding the syntax of C#.
-->
アクションはC#で実装されています。C#の構文について疑問がある場合は、C#のドキュメントを利用できます。

<!-- #### Timer Control -->
#### タイマー制御 (Timer Control)

<!--
These actions are repeatedly triggered while LiveSplit is connected to the game process.
-->
LiveSplitがゲームプロセスに接続されている間、これらのアクションは繰り返し発動されます。

<!-- ##### Generic Update -->
##### 一般更新 (Generic Update)

<!--
The name of this action is `update`. You can use this for generic updating. In each update iteration, this is run before the timer control actions, which e.g. means if you set a value in `vars` in `update` you can then access it in `start` on the same update cycle.
-->
このアクションの名前は`update`です。これは一般更新に使用できます。更新の反復中、これはタイマー制御動作の前に実行されます。もし`update`の`vars`に値を設定すれば、同じ更新サイクルの`start`でそれにアクセスできるということです。

<!--
Explicitly returning `false` will prevent the actions `isLoading`, `gameTime`, `reset`, `split`, and `start` from being run. This can be useful if you want to entirely disable the script under some conditions (e.g. for incompatible game versions). See [Order of Execution](#order-of-execution) for more information.
-->
明示的にfalseを返すと、`isLoading`, `gameTime`, `reset`, `split`, `start`アクションが実行されなくなります。これは、状況によってはスクリプトを完全に無効にしたい場合(たとえば、互換性のないゲームバージョンなど)に役立ちます。詳細は[実行順序 (Order of Execution)](#実行順序-order-of-execution)参照してください。

<!-- ##### Automatic Timer Start -->
##### 自動タイマースタート (Automatic Timer Start)

<!--
The name of this action is `start`. Return `true` whenever you want the timer to start. Note that the `start` action will only be run if the timer is currently not running.
-->
このアクションの名前は`start`です。タイマーを起動したいときは常に`true`を返してください。`start`アクションはタイマーが現在実行されていない場合にのみ実行されることに注意してください。

<!-- ##### Automatic Splits -->
##### 自動スプリット (Automatic Splits)

<!--
The name of this action is `split`. Return `true` whenever you want to trigger a split.
-->
このアクションの名前は`split`です。スプリットを実行したいときは常に`true`を返してください。

<!-- ##### Automatic Resets -->
##### 自動リセット (Automatic Resets)

<!--
The name of this action is `reset`. Return `true` whenever you want to reset the run.
-->
このアクションの名前は`reset`です。タイマーをリセットしたいときは常に`true`を返してください。

<!--
Explicitly returning `true` will prevent the `split` action from being run. This can be useful in some cases, but may also cause issues for some scripts. See [Order of Execution](#order-of-execution) for more information.
-->
明示的に`true`を返すことは`split`アクションの実行を防ぎます。これは場合によっては便利ですが、スクリプトによっては問題を引き起こす可能性があります。詳細は詳細は[実行順序 (Order of Execution)](#実行順序-order-of-execution)を参照してください。

<!-- ##### Load Time Removal -->
##### ロード時間の除去 (Load Time Removal)

<!--
The name of this action is `isLoading`. Return `true` whenever the game is loading. LiveSplit's Game Time Timer will be paused as long as you return `true`.
-->
このアクションの名前は`isLoading`です。ゲームのロード中は常に`true`を返してください。 LiveSplitのゲーム時間タイマーは、`true`が返される限り一時停止します。

<!-- ##### Game Time -->
##### ゲームタイム (Game Time)

<!--
The name of this action is `gameTime`. Return a [`TimeSpan`](https://msdn.microsoft.com/en-us/library/system.timespan(v=vs.110).aspx) object that contains the current time of the game. You can also combine this with `isLoading`. If `isLoading` returns false, nothing, or isn't implemented, LiveSplit's Game Time Timer is always running and syncs with the game's Game Time at a constant interval. Everything in between is therefore a Real Time approximation of the Game Time. If you want the Game Time to not run in between the synchronization interval and only ever return the actual Game Time of the game, make sure to implement `isLoading` with a constant return value of `true`.
-->
このアクションの名前は`gameTime`です。現在のゲームの時間の入った[`TimeSpan`](https://docs.microsoft.com/ja-jp/dotnet/api/system.timespan)オブジェクトを返します。これを`isLoading`と組み合わせることもできます。`isLoading`がfalseを返す場合・何もしない場合・実装されていない場合、LiveSplitのゲーム時間タイマーは常に実行されており、一定の間隔でゲームのGame Timeと同期します。したがって、その間のタイムはすべて、リアルタイムをゲームタイムに近似した値です。同期の合間にゲームタイムを進ませずにゲームの実際のゲームタイムのみを返すようにしたい場合は、定数`true`の戻り値を持つ`isLoading`を必ず実装してください。

<!-- ##### Order of Execution -->
##### 実行順序 (Order of Execution)

<!--
Understanding the order and conditions under which timer control actions are executed can help you avoid issues in your script where variables appear to be set improperly, actions appear to be skipped, and more. Every update iteration follows this process when running actions:
-->
タイマー制御アクションが実行される順序と条件を理解すると、スクリプトの問題(変数が不適切に設定されているように見えたり、アクションがスキップされたりしているように見えるなど)の回避の助けになります。アクションの実行時、更新の反復はすべてこのプロセスに従います。

<!--
1. `update` will always be run first. There are no conditions on the execution of this action.
2. If `update` did not explicitly return `false` and the timer is currently either running or paused, then the `isLoading`, `gameTime`, and `reset` actions will be run.
  - If `reset` does not explicitly return `true`, then the `split` action will be run.
3. If `update` did not explicitly return `false` and the timer is currently not running (and not paused), then the `start` action will be run.
-->
1. `update`は常に最初に実行されます。このアクションの実行に条件はありません。
2. `update`が明示的に`false`を返さず、タイマーが現在実行中または一時停止中の場合、`isLoading`・`gameTime`・`reset`アクションが実行されます。
  - `reset`アクションが明示的に`true`を返さない場合は、`split`アクションが実行されます。
3. `update`が明示的に`false`を返さず、タイマーが現在実行されていない(かつ一時停止中でない)場合は、`start`アクションが実行されます。

<!-- #### Script Management -->
#### スクリプト管理 (Script Management)

<!-- ##### Script Startup -->
##### スクリプトの起動 (Script Startup)

<!--
The name of this action is `startup`. This action is triggered when the script is first loads. This is the place where you can put initialization that doesn't depend on being connected to the process and the only place where you can add [Custom Settings](#custom-settings).
-->
このアクションの名前は`startup`です。このアクションは、スクリプトが最初にロードされたときに発動されます。これはプロセスへの接続に依存しない初期化を置くことができる場所であり、[カスタム設定 (Custom Settings)](#カスタム設定-custom-settings)を追加できる唯一の場所です。

<!-- ##### Script Shutdown -->
##### スクリプトの停止 (Script Shutdown)

<!--
The name of this action is `shutdown`. This action is triggered whenever the script is entirely stopped, for example when the Auto Splitter is disabled, LiveSplit exits, the script path is changed or the script is reloaded (e.g. during development of the ASL script).
-->
このアクションの名前は`shutdown`です。このアクションは、自動スプリットが無効になる・LiveSplitが終了する・スクリプトのパスが変更される・スクリプトが再ロードされる(ASLスクリプトの開発中など)など、スクリプトが完全に停止するたびに発動されます。

<!-- ##### Script Initialization (Game Start) -->
##### スクリプトの初期化 (Script Initialization (Game Start))

<!--
The name of this action is `init`. This action is triggered whenever a game process has been found according to the State Descriptors. This can occur more than once during the execution of a script (e.g. when you restart the game). This is the place to do initialization that depends on the game, for example detecting the game version.
-->
このアクションの名前は`init`です。このアクションは、状態記述子に一致したゲームプロセスが見つかると発動されます。これは、スクリプトの実行中に複数回発生する可能性があります(ゲームを再起動したときなど)。ここはゲームのバージョンの検出など、ゲームに応じた初期化を行う場所です。

<!-- ##### Game Exit -->
##### ゲームの終了 (Game Exit)

<!--
The name of this action is `exit`. This action is triggered whenever the currently attached game process exits.
-->
このアクションの名前は`exit`です。このアクションは、現在接続されているゲームプロセスが終了するたびに発動されます。


<!-- ### Action Variables -->
### アクション変数 (Action Variables)

<!--
Actions have a few hidden variables available.
-->
アクションには隠れた変数がいくつかあります。

<!-- #### General Variables -->
#### 一般的な変数 (General Variables)

<!-- ##### vars -->
##### vars
<!--
A dynamic object which can be used to store variables. Make sure the variables are defined (for example in `startup` or `init`) before trying to access them. This can be used to exchange data between Actions.
-->
変数の格納に使用できる動的オブジェクト。アクセスする前に、その変数が定義されている(例えば`startup`や`init`で)ことを確認してください。これはアクション間のデータのやり取りに使用できます。
<!--
```
init { vars.test = 5; }
update { print(vars.test.ToString()); }
```
-->
```
init { vars.test = 5; }
update { print(vars.test.ToString()); }
```
<!--
You can also store variables like this in `current` and the value will be in `old` on the next update.
-->
このような変数を`current`に格納することもでき、その値は次回更新時には`old`に入ります。

<!-- ##### version -->
##### version
<!--
When you set `version` in `init`, the corrosponding State Descriptor will be activated. When there is no State Descriptor corrosponding to the `version`, the default one will be activated.

The default is the first defined State Descriptor with no version specified, or the first State Descriptor in the file if there is none with no version specified.

The string you set `version` to will also be displayed in the ASL Settings GUI.
-->
`init`に`version`を設定すると、それに対応する状態記述子が有効になります。`version`に対応する状態記述子が存在しない場合は、デフォルトのものが有効になります。

デフォルトとは、バージョン指定されていない状態記述子のうち最初に定義されているものです。バージョン指定されたものがない場合は、ファイル内の最初のものです。

`version`に設定した文字列は、ASL設定GUIにも表示されます。
<!--
```
state("game", "v1.2")
{
    byte levelID : 0x9001;
}
state("game", "v1.3")
{
    byte levelID : 0x9002;
}
init
{
    if (modules.First().ModuleMemorySize == 0x123456)
        version = "v1.2";
    else if (modules.First().ModuleMemorySize == 0x654321)
        version = "v1.3";
}
update
{
    if (version == "") return false;
    print(current.levelID.ToString());
}
```
-->
```
state("game", "v1.2")
{
    byte levelID : 0x9001;
}
state("game", "v1.3")
{
    byte levelID : 0x9002;
}
init
{
    if (modules.First().ModuleMemorySize == 0x123456)
        version = "v1.2";
    else if (modules.First().ModuleMemorySize == 0x654321)
        version = "v1.3";
}
update
{
    if (version == "") return false;
    print(current.levelID.ToString());
}
```

<!-- ##### refreshRate -->
##### refreshRate
<!--
Many actions are triggered repeatedly, by default approximately 60 times per second. You can set this variable lower to reduce CPU usage. This is commonly done in `startup` or `init`.
-->
多くのアクションは繰り返し(デフォルトでは1秒間に約60回)発動されます。この変数を低く設定すると、CPU使用率を減らすことができます。これは一般に`startup`または`init`で行われます。
<!--
```
refreshRate = 30;
```
-->
```
refreshRate = 30;
```

<!-- ##### settings -->
##### settings
<!--
Used to add and access [Settings](#settings-1).
-->
[設定 (Settings)](#設定-settings)の追加とアクセスのために使用します。

<!-- #### Game Dependent -->
#### ゲーム依存 (Game Dependent)

<!--
These variables depend on being or having been connected to a game process and are not available in the `startup` or `exit` actions and only partly available in `shutdown` (might be `null`).
-->
これらの変数はゲームのプロセスに接続されているかどうかによって異なり、`startup`や`exit`アクションでは利用できず、`shutdown`では部分的にしか利用できません(`null`かもしれない)。

<!-- ##### current / old -->
##### current / old
<!--
State objects representing the current and previous states.
-->
現在および以前の状態を表す状態オブジェクト。
<!--
```
split { return current.levelID != old.levelID; }
```
-->
```
split { return current.levelID != old.levelID; }
```

<!-- ##### game -->
##### game
<!--
The currently connected [Process](https://msdn.microsoft.com/en-us/library/system.diagnostics.process%28v=vs.110%29.aspx) object.
-->
現在接続されている[プロセス](https://docs.microsoft.com/ja-jp/dotnet/api/system.diagnostics.process)オブジェクト。
<!--
```
update { if (game.ProcessName == "snes9x") { } }
```
-->
```
update { if (game.ProcessName == "snes9x") { } }
```

<!-- ##### modules -->
##### modules
<!--
The modules of the currently connected process. Please use this instead of game.Modules! Use modules.First() instead of game.MainModule.
-->
現在接続されているプロセスのモジュール。`game.Modules`の代わりにこれを使ってください！　`game.MainModule`の代わりに`modules.First()`を使用してください。

<!-- ##### memory -->
##### memory
<!--
Provides a means to read memory from the game without using the State Descriptor.
-->
状態記述子を使用せずゲームからメモリを読み取るための手段を提供します。
<!--
```
vars.exe = memory.ReadBytes(modules.First().BaseAddress, modules.First().ModuleMemorySize);
vars.test = memory.ReadValue<byte>(modules.First().BaseAddress + 0x9001);
vars.test2 = memory.ReadString(modules.First().BaseAddress + 0x9002, 256);
vars.test3 = new DeepPointer("some.dll", 0x9003, vars.test, 0x02).Deref<int>(game);
vars.test4 = memory.ReadString(modules.Where(m => x.ModuleName == "some.dll").First().BaseAddress + 0x9002, 256);
```
-->
```
vars.exe = memory.ReadBytes(modules.First().BaseAddress, modules.First().ModuleMemorySize);
vars.test = memory.ReadValue<byte>(modules.First().BaseAddress + 0x9001);
vars.test2 = memory.ReadString(modules.First().BaseAddress + 0x9002, 256);
vars.test3 = new DeepPointer("some.dll", 0x9003, vars.test, 0x02).Deref<int>(game);
vars.test4 = memory.ReadString(modules.Where(m => x.ModuleName == "some.dll").First().BaseAddress + 0x9002, 256);
```

<!-- ### Settings -->
### 設定 (Settings)

<!--
ASL script settings are stored either with the Layout if you are using the Scriptable Auto Splitter component or with the Splits if you activated the script in the Splits Editor (so make sure to save your Layout or Splits accordingly when exiting LiveSplit if you changed settings).
-->
ASLスクリプト設定は、Scriptable Auto Splitterコンポーネントを使用している場合はレイアウトと一緒に、スプリットエディタでスクリプトを有効にした場合はスプリットファイルと一緒に保存されます(なので、設定を変更した場合はLiveSplitを終了するときにレイアウトまたはスプリットファイルを保存してください)。

<!-- #### Basic Settings -->
#### 基本設定 (Basic Settings)
<!--
The Auto Splitter Settings GUI has some default settings to allow the user to toggle the actions `start`, `reset` and `split`. If the checkbox for an action is unchecked, the return value of that action is ignored (but the code inside the action is still executed). So for example if the checkbox for `start` is unchecked, returning `true` in the `start` action will have no effect.
-->
Auto Splitter設定GUIでは、デフォルトで`start`・`reset`・`split`アクションの切り替えが可能です。アクションのチェックボックスがオフの場合、そのアクションの戻り値は無視されます(ただし、そのアクション内のコードは実行されます)。そのため、例えば`start`のチェックボックスがオフの場合、`start`アクションで`true`を返しても効果はありません。

<!--
You can access the current value of the basic settings through the attributes `settings.StartEnabled`, `settings.ResetEnabled` and `settings.SplitEnabled`. This is only for informational purposes, for example if your script needs to do something depending on whether the action was actually performed or not, ignoring the return value is done automatically.
-->
基本設定の現在値には、`settings.StartEnabled`・`settings.ResetEnabled`・`settings.SplitEnabled`の属性を通してアクセスできます。これは情報提供のみを目的としています。たとえば、アクションが実際に実行されたかどうかに応じてスクリプトが何かする必要がある場合、戻り値の無視は自動的に行われます。

<!--
Actions that are not present in the ASL script or empty will have their checkboxes disabled.
-->
ASLスクリプトに存在しないまたは空のアクションは、チェックボックスがオフにされます。

<!-- #### Custom Settings -->
#### カスタム設定 (Custom Settings)

<!--
You can define custom boolean settings for your script in the `startup` action and then access the setting values as configured by the user in the other actions. If you have custom settings defined, they will be shown in the GUI for the user to check/uncheck. They will appear in the same order you added them in the ASL script.
-->
 あなたのスクリプトのカスタムブール設定を`startup`アクションで定義すれば、ユーザの設定値へ他のアクションからアクセスすることができます。カスタム設定が定義されている場合は、ユーザーがチェック/チェック解除できるようにGUIに表示されます。それらは、ASLスクリプトで追加したのと同じ順序で表示されます。

<!-- ##### Basic usage -->
##### 基本的な使い方 (Basic usage)

<!--
You can define settings in the `startup` action by using the `settings.Add(id, default_value = true, description = null, parent = null)` method:
-->
`settings.Add(id, default_value = true, description = null, parent = null)`メソッドを使うことにより、`startup`アクションで設定を定義できます:

<!--
```
// Add setting 'mission1', enabled by default, with 'First Mission' being displayed in the GUI
settings.Add("mission1", true, "First Mission");

// Add setting 'mission2', enabled by default, with 'mission2' being displayed in the GUI
settings.Add("mission2");

// Add setting 'mission3', disabled by default, with 'mission3' being displayed in the GUI
settings.Add("mission3", false);
```
-->
```
// 設定'mission1'を追加、デフォルトで有効、'First Mission'としてGUIに表示
settings.Add("mission1", true, "First Mission");

// 設定'mission2'を追加、デフォルトで有効、'mission2'としてGUIに表示
settings.Add("mission2");

// 設定'mission3'を追加、デフォルトで無効、'mission2'としてGUIに表示
settings.Add("mission3", false);
```

<!--
You can access the current value of a setting in all actions other than `startup` by accessing `settings`:
-->
`startup`以外のすべてのアクションでは、`settings`にアクセスすることで設定の現在値にアクセスすることができます。

<!--
````
// Do something depending on the value of the setting 'mission1'
if (settings["mission1"]) {  }
````
-->
````
// 設定'mission1'の値に応じて何かを行う
if (settings["mission1"]) {  }
````

<!-- ##### Grouping settings -->
##### 設定のグループ化 (Grouping settings)
<!--
If you want to organize the settings in a hierarchy, you can specify the `parent` parameter. Note that the `parent` has to be the `id` of a setting that you already added:
-->
設定を階層的に整理したい場合は、`parent`パラメータを指定できます。`parent`は既に追加した設定の`id`でなければならないことに注意してください:

<!--
```
// Add setting 'main_missions'
settings.Add("main_missions", true, "Main Missions");

// Add setting 'mission1', with 'main_missions' as parent
settings.Add("mission1", true, "First Mission", "main_missions");
```
-->
```
// 設定'main_missions'を追加
settings.Add("main_missions", true, "Main Missions");

// 設定'mission1'を追加し、'main_missions'を親とする
settings.Add("mission1", true, "First Mission", "main_missions");
```

<!--
Settings only return `true` (checked) when their `parent` setting is `true` as well. The user can still freely toggle settings that have their parent unchecked, however they will be grayed out to indicate they are disabled.
-->
Settingsは、`parent`設定が同様に`true`である時に限り`true`(チェックあり)を返します。ユーザーは、チェックが外れた親を持つ設定も自由に切り替えれますが、無効であることを示すためにグレー表示されます。

<!--
Any setting can act as a `parent` setting, so you could for example do the following to go one level deeper (continuing from the last example):
-->
どの設定も`parent`設定としての振る舞いが可能です。例えば、次のようにして一つ下の階層へ行けます(最後の例から続けて)：

<!--
```
// Add setting 'mission1_part1', with 'mission1' as parent
settings.Add("mission1_part1", true, "First part of Mission 1", "mission1");
```
-->
```
// 設定'mission1_part1'を追加し、'mission1'を親とする
settings.Add("mission1_part1", true, "First part of Mission 1", "mission1");
```

<!--
The setting `mission1_part1` will only be enabled, when both `mission1` and `main_missions` are enabled.
-->
設定`mission1_part1`は、`mission1`と`main_missions`の両方が有効になっている場合にのみ有効になります。

<!--
When the `parent` parameter is null or omitted, the setting will be added as top-level setting, unless `settings.CurrentDefaultParent` is set to something other than `null`:
-->
`parent`パラメータが`null`であるか省略されている場合は、`settings.CurrentDefaultParent`が`null`に設定されている限り、設定はトップレベルに追加されます。

<!--
```
// Add top-level setting 'main_missions'
settings.Add("main_missions");

settings.CurrentDefaultParent = "main_missions";

// Add setting 'mission1', with the parent 'main_missions'
settings.Add("mission1");

settings.CurrentDefaultParent = null;

// Add top-level setting 'side_missions'
settings.Add("side_missions");
```
-->
```
// トップレベル設定'main_missions'を追加
settings.Add("main_missions");

settings.CurrentDefaultParent = "main_missions";

// 設定'mission1'を追加、'main_missions'を親とする
settings.Add("mission1");

settings.CurrentDefaultParent = null;

// トップレベル設定'side_missions'を追加
settings.Add("side_missions");
```

<!--
Using `settings.CurrentDefaultParent` can be useful when adding several settings with the same parent, without having to specify the parent everytime.
-->
`settings.CurrentDefaultParent`を使うと、同じ親を持つ設定を追加するときに便利です。毎回親を指定する必要がありません。

<!-- ##### Tooltips -->
##### ツールチップ (Tooltips)

<!--
You can add a tooltip to settings that appears when hover over the setting in the GUI. This can be useful if you want to add a bit more information. After adding the setting, use `settings.SetToolTip(id, tooltip_text)` to set a tooltip:
-->
GUI設定の上にマウスを移動すると表示されるツールチップを追加できます。もう少し情報を追加したい場合に便利です。設定を追加したら、`settings.SetToolTip(id, tooltip_text)`を使ってツールチップを設定します。

<!--
```
settings.Add("main_missions", true, "Main Missions");
settings.SetToolTip("main_missions", "All main story missions, except Mission A and Mission B");
```
-->
```
settings.Add("main_missions", true, "Main Missions");
settings.SetToolTip("main_missions", "All main story missions, except Mission A and Mission B");
```

<!-- ### Built-in Functions -->
### ビルトイン関数 (Built-in Functions)

<!-- ##### print -->
##### print
<!--
Used for debug printing. Use [DbgView](https://technet.microsoft.com/en-us/Library/bb896647.aspx) to watch the output.
-->
デバッグ出力に使用されます。出力を見るには[DbgView](https://technet.microsoft.com/ja-jp/sysinternals/debugview.aspx)を使用してください。
<!--
```
print("current level is " + current.levelID);
```
-->
```
print("current level is " + current.levelID);
```

<!-- ##### Other -->
##### Other

<!--
There are some advanced memory utilities not covered here. You can find them [here](../LiveSplit/LiveSplit.Core/ComponentUtil).
-->
ここでは説明していない高度なメモリユーティリティは[こちら](https://github.com/LiveSplit/LiveSplit/tree/master/LiveSplit/LiveSplit.Core/ComponentUtil)にあります。

<!-- ### Testing your Script -->
### スクリプトのテスト (Testing your Script)

<!--
You can test your Script by adding the *Scriptable Auto Splitter* component to your Layout. Right-click on LiveSplit and choose "Edit Layout..." to open the Layout Editor, then click on the Plus-sign and choose "Scriptable Auto Splitter" from the section "Control". You can set the Path of the Script by going into the component settings of the Scriptable Auto Splitter. To get to the settings of the component you can either double click it in the Layout Editor or go into to the Scriptable Auto Splitter Tab of the Layout Settings. Once you've set the Path, the script should automatically load and hopefully work.
-->
レイアウトに*Scriptable Auto Splitter*コンポーネントを追加することによって、スクリプトのテストができます。LiveSplitを右クリックして"Edit Layout..."を選択してLayout Editorを開き、次にプラス記号をクリックして"Control"セクションから "Scriptable Auto Splitter"を選択します。Scriptable Auto Splitterのコンポーネント設定に入ることでスクリプトのパスを設定することができます。コンポーネントの設定に到達するには、Layout Editorでそれをダブルクリックするか、またはレイアウト設定のScriptable Auto Splitterタブを開きます。パスを設定したら、スクリプトは自動的にロードされ、うまくいけば動作するはずです。

<!-- #### Debugging -->
#### デバッグ (Debugging)
<!--
Reading debug output is an integral part of developing ASL scripts, both for your own debug messages which you can output with `print()` and any debug messages or error messages the ASL Component itself provides.
-->
デバッグ出力を読むことは、ASLスクリプト開発に不可欠な部分です。`print()`で出力できるあなた自身のデバッグメッセージと、ASLコンポーネント自身のデバッグメッセージまたはエラーメッセージの両方です。

<!--
The program [DebugView](https://technet.microsoft.com/en-us/sysinternals/debugview.aspx) can be used for a live view of debug output from the ASL Component.
-->
[DbgView](https://technet.microsoft.com/ja-jp/sysinternals/debugview.aspx)プログラムは、ASLコンポーネントのデバッグ出力のライブビューに使用できます。

<!--
For errors, you can also check the Windows Event Logs, which you can find via:
-->
エラーが発生した場合は、Windowsのイベントログも確認できます:

<!--
Control Panel ? Search for Event Viewer ? Open it ? Windows Logs ? Application ? Find the LiveSplit Errors
-->
コントロール パネル → "イベント ログの表示"を検索 → 開く → Windows ログ → Application → "LiveSplit"のエラーを検索

<!--
Some might be unrelated to the Script, but it'll be fairly obvious which ones are caused by you.
-->
スクリプトとは無関係なエラーもあるかもしれませんが、どれかがあなたによって引き起こされたのは間違いないでしょう。

<!-- ## Adding an Auto Splitter -->
## Auto Splitterの追加 (Adding an Auto Splitter)

<!--
If you implemented an Auto Splitter and want to add it to the Auto Splitters that are automatically being downloaded by LiveSplit, feel free to add it to the [Auto Splitters XML](../LiveSplit.AutoSplitters.xml). Just click the link, click the icon for modifying the file and GitHub will automatically create a fork, branch and pull request for you, which we can review and then merge in.
-->
実装したAuto Splitterを、LiveSplitによって自動ダウンロードされるAuto Splittersに追加したい場合は、[Auto Splitters XML](https://github.com/LiveSplit/LiveSplit/blob/master/LiveSplit.AutoSplitters.xml)に追加してください。リンクをクリックし、ファイルを変更するアイコンをクリックするだけで、GitHubがfork・branch・pull requestを自動的に作成してくれます。我々はこれをレビューしてマージできます。

<!-- ## Additional Resources -->
## 資料 (Additional Resources)

<!--
- [Speedrun Tool Development Discord](https://discord.gg/N6wv8pW)
- [List of ASL Scripts](https://fatalis.pw/livesplit/asl-list/) to learn from, automatically created from the [Auto Splitters XML](../LiveSplit.AutoSplitters.xml) and filterable by different criteria
- Example: [Simple Autosplitter with Settings](https://raw.githubusercontent.com/tduva/LiveSplit-ASL/master/AlanWake.asl)
-->
- [スピードランツール開発Discord](https://discord.gg/N6wv8pW)
- 学習用の[ASLスクリプトリスト](https://fatalis.pw/livesplit/asl-list/): [Auto Splitters XML](https://github.com/LiveSplit/LiveSplit/blob/master/LiveSplit.AutoSplitters.xml)から自動的に生成され、さまざまな基準でフィルタリング可能
- 例: [Settingsつきの単純なAuto Splitter](https://raw.githubusercontent.com/tduva/LiveSplit-ASL/master/AlanWake.asl)

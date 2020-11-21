# FunLocks-handson-ios

FunLocks「iOS&amp;ビーコン勉強会」向けサンプルアプリ

ビーコンの検知機能を持ち，検知した信号の情報を表示するアプリ．

## BLEビーコン

### BLEビーコンとは何か

BLEビーコンは，[BLE（Bluetooth Low Energy）](https://ja.wikipedia.org/wiki/Bluetooth_Low_Energy)という通信技術を利用し，周囲に信号を発信し続ける端末です．消費電力が小さく，電池1個で1年以上使うことができます．小型端末のため，様々な場所に取り付けることが可能です．屋内での測位においては，GPSより優れています．

### iBeacon

[iBeacon](https://developer.apple.com/ibeacon/)は，Appleが2013年に発表した，BLEビーコンの一種です．この規格では，以下のような特徴があります．

- 100ミリ秒ごとに信号を発信する（1秒に10回）
- ビーコンと受信端末の距離を概算できる
- 一度に検知できる信号（リージョン）は，最高で20個

これ以降の文章では，iBeacon（以下ビーコン）を前提として説明します．

### ビーコン信号を利用して得られる情報

iOS端末でiBeaconの信号を受信して扱える情報の例は，以下の通りです．

- Proximity（近接度．近い順に「Immediate」「Near」「Far」の3段階）
- RSSI（信号強度．最大で数メートルの誤差）
- Accuracy（ビーコンとの距離．単位：メートル）
- Timestamp（最終観測時刻）
- UUID（ビーコンの固有ID．1つの組織が1つのUUIDを使うといった使い方をする）
- Major/Minor（同じUUIDを持つビーコンを区別するための値．例えば，建物／階数ごとに設置するビーコンの値を変えることで，建物／階数の特定に利用可能）

## 前準備

### Apple IDの取得

[Appleのサイト](https://appleid.apple.com/)から，Apple IDを取得してください．

### Xcodeのインストール

[MacのApp Store](https://apps.apple.com/jp/app/xcode/id497799835?mt=12)から，Xcodeの最新版をインストールしてください．

### 開発環境の確認

本ドキュメントで基準とした開発環境は以下の通りです．バージョンが異なっても構いませんが，挙動が異なる場合があるかもしれません．

- Xcodeのバージョン：12.0.1
- iOSのバージョン：14.0
- 対象端末：iPhone

## プロジェクトの用意

Xcodeを開き，最初の画面で**Create a new Xcode project**を選択します．

![](README_image/01.png)

**App**を選択して，**Next**を押します．

![](README_image/02.png)

**Product Name**に任意の名前を入力してください．**Interface**は，必ず**Storyboard**にしてください．**Life Cycle**は，**UIKit App Delegate**にしてください．確認を終えたら**Next**を押します．

![](README_image/03.png)

プロジェクトを保存する場所の指定画面が出ます．好きな場所を選択してください．保存を終えると，下のような画面に遷移します．

![](README_image/04.png)

iPhoneだけで動くアプリを作るため，**iPhone**だけにチェックをつけます．縦向き表示だけにするため，Device Orientationの**Portrait**だけチェックをつけます．

![](README_image/05.png)

これでプロジェクトの準備は完了です．

### ビーコン検知用のデータ作成

検知したいビーコンの情報を，アプリ側に予め用意しておきます．

**BeaconData.json**という名前のファイルを，任意のエディタで作成してください．作成できたら，以下の記述をコピー＆ペーストして保存してください．

``` json
[
    {
        "id": 1001,
        "name": "Beacon1",
        "info": {
            "uuid": "48534442-4C45-4144-80C0-1800FFFFFFF0",
            "major": 100,
            "minor": 1
        }
    },
    {
        "id": 1002,
        "name": "Beacon2",
        "info": {
            "uuid": "48534442-4C45-4144-80C0-1800FFFFFFF1",
            "major": 100,
            "minor": 1
        }
    }
]
```

保存できたら，プロジェクトに**BeaconData.json**を追加します．**BeaconSample**というディレクトリにカーソルを合わせて右クリックし，出てきたメニューの**Add Files to "BeaconSample"...**を選択してください．出てきた画面で，**BeaconData.json**を選択して**Add**を押すと，プロジェクトに追加されます．

![](README_image/06.png)

出てきた画面で，**BeaconData.json**を選択して**Add**を押すと，プロジェクトに追加されます．正しく追加できると，以下のような表示になります．

![](README_image/07.png)

### ビーコンを表すデータモデル作成

作成したBeaconData.json内のデータを扱うため，1つのビーコンを表すためのデータモデルを作成します．データモデルには以下の情報を持たせます．

- id（ビーコンごとに割り振るID）
- name（ビーコンにつける名前）
- info（ビーコンが持つ値を格納するデータモデルInfo）

上記のうち，**info**に含まれるデータは以下の情報です．（各値の役割については，**ビーコン信号を利用して得られる情報**を参照）

- uuid
- major
- minor

これら2つのデータモデルを実現します．画面上のメニューから，File>New>File...を選択してください．

![](README_image/08.png)

**Swift File**を選択します．

![](README_image/09.png)

名前を**Beacon.swift**にして，**Create**を押します．

![](README_image/10.png)

作成されたファイルは，下図のような中身が書かれています．

![](README_image/11.png)

Beacon.swiftにBeaconモデルを作ります．以下の記述を追加します．

``` swift
struct Beacon: Codable, Identifiable {
    let id: Int
    let name: String
    let info: Info
}
```

[Codable](https://developer.apple.com/documentation/swift/codable)は，**ビーコン検知用のデータ作成**で作成したJSONファイルをデコード（Swiftで扱える形式に変換）するためにつけます．

[Identifiable](https://developer.apple.com/documentation/swift/identifiable)は，一つ一つのオブジェクトが**一意（他と重複しない）であることを保証する**ための記述です．Beaconモデルの中で一意な変数は，**id**です．

続いて，Beaconモデル内で使われている**Info**を作ります．以下の記述を追加します．

``` swift
struct Info: Codable {
    let uuid: String
    let major: Int
    let minor: Int
}
```

これで，データモデルを作れました．

### JSONファイルをデコードする関数を作成

ビーコンのデータモデルに合わせて，JSONをデコードする関数を作ります．

**BeaconSample**というディレクトリにカーソルを合わせて右クリックし，出てきたメニューの**New File...**を選択してください．

![](README_image/12.png)

出てきた画面で，**Swift File**を選択して**Next**を押すと，名前の入力画面が出ます．**Data.swift**として，**Create**を押すと追加されます．

![](README_image/13.png)

Data.swiftを開き，以下の記述を追加します．

``` swift
import UIKit

let beaconData: [Beacon] = load("BeaconData.json")

func load<T: Codable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
```

これにより，他のファイル内でも，ビーコンの情報を格納した**beaconData**という配列が使えるようになりました．

### 2つの画面を作成（.swiftファイル）

これ以降，アプリの画面を2つ実装します．

- ビーコン選択画面（BeaconListViewController.swift）
- ビーコン検知・情報表示画面（SearchViewController.swift）

**ViewController.swift**の名前を**BeaconListViewController.swift**に変更します．ViewController.swiftを長押しして離すと，名前を変更できます．

名前を変更した後にBeaconListViewControllerを開き，`class ViewController`の部分を`class BeaconListViewController`に変更してください．

変更後は以下のようになります．

![](README_image/14.png)

2つ目の画面として，**SearchViewController.swift**というファイルを作成します．

**BeaconSample**というディレクトリにカーソルを合わせて右クリックし，出てきたメニューの**New File...**を選択してください．

出てきた画面で，**Cocoa Touch Class**を選択します．

![](README_image/15.png)

**Next**を押すと，名前の入力画面が出ます．**SearchViewController.swift**として，**Next**を押します．ファイルを追加する場所が合っていれば，そのまま**Create**を押します．

これで，2つの画面を作るためのファイルが用意できました．

### 2つの画面を作成（.storyboardファイル）

Main.storyboardを開き，画面右上の＋ボタンを押します．出てきたビューの検索欄に，**ViewController**と入力します．

![](README_image/16.png)

最初から配置されているViewControllerの右横に，**ViewController**をドラッグ＆ドロップで配置します．配置した後の図は以下です．

![](README_image/17.png)

先ほど作成した，2つの.swiftファイルを関連づけます．左側のViewControllerを選択し，上に表示されるマークの一番左を選択します（下図で青くなっている部分）．

![](README_image/18.png)

画面右のエリアで，Classを**BeaconListViewController**に変更します．

![](README_image/19.png)

同様に右のViewControllerも選択し，Classを**SearchViewController**に変更します．これで.storyboardと.swiftの関連づけが完了しました．

### ビーコンリストを表示する

下のような画面を作ります．

![](README_image/20.jpeg)

画面下にビーコンリストが表示され，タップすることで詳細画面に遷移します．遷移はここで実装せず，もう一つの画面を実装するときに実装します．

Main.storyboardを開き，画面サイズの設定をします．画面下のエリアで，**View as**のところをクリックして，対象端末を指定します．

![](README_image/21.png)

次に右上の＋ボタンを押します．**TableView**と入力し，検索結果に出てきた**TableView**をドラッグ＆ドロップし，左のViewController内に配置します．

![](README_image/22.png)

AutoLayoutについて説明すると面倒なので，ひとまずいい感じに大きさを調整して配置します．AutoLayoutについては発展編で触れます．

![](README_image/23.png)

配置できたら，画面右上あたりにある以下のアイコンをクリックし，画面を2列にしてください．

![](README_image/24.png)

2列にしたあと，左側にBeaconListViewController.swiftを表示させると，以下のようになります．

![](README_image/25.png)

Main.storyboardで配置したTableViewを，BeaconListViewController.swiftに関連づけます．TableViewから，**controlキーを押しながら**BeaconListViewController.swiftへドラッグ＆ドロップします．

![](README_image/26.png)

名前を**tableView**として**Connect**を押します．

![](README_image/27.png)

正しく関連づけることができれば，コードが以下のように変化します．

![](README_image/28.png)

次に，BeaconListViewControllerでtableViewを操作するための設定をします．再度Main.storyboardに配置されたTableViewを選択し，ViewController上にあるマークへ，**controlキー**を押しながらドラッグ＆ドロップします．

![](README_image/29.png)

出てきたダイアログのうち，**dataSource**を選択します．

![](README_image/30.png)

同様の手順をもう一度繰り返し，**delegate**も選択してください．

上記の操作が完了したら，次は**BeaconListViewController.swift**を編集します．

ファイルの一番下の行から，以下の記述を追加します．

``` swift
extension BeaconListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TableViewCellがタップされたときの処理
    }
}

extension BeaconListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beaconData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.accessoryType = .disclosureIndicator
        // ここでTableViewCellへ表示する情報を指定する
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Observable - 観測可能"
    }
}
```

2つのextensionにより，BeaconListViewControllerというclassは，**UITableViewDelegate**，**UITableViewDataSource**という2つのprotocolを持つようになりました．これによって，以下のようなことが可能になります．

- TableViewに表示するTableViewCellの行数指定
- TableViewCellのスタイル指定
- TableViewCellに表示する情報の指定
- TableViewCellをタップしたときの挙動の指定

これら以外にも，関数によって可能になる処理があります．詳細は[UITableViewDelegate](https://developer.apple.com/documentation/uikit/uitableviewdelegate)や[UITableViewDataSource](https://developer.apple.com/documentation/uikit/uitableviewdatasource)を参照してください．

ここで一度，iPhoneへビルドして動かしてみます．MacにiPhoneをケーブルで繋ぎます．接続したiPhoneを対象に選択して，三角のボタンを押してビルドします．

![](README_image/31.png)

ビルドすると，下の画面のようになります．

![](README_image/32.jpeg)

何も書いていないTableViewCellが，2行表示されています．今のところ，タップしても変化はありません．

次に，2行のTableViewCellに以下の情報を表示させてみます．

- ビーコンに割り当てられた名前（Beaconモデルのname）
- ビーコンのUUID（Infoモデルのuuid）

**extension BeaconListViewController: UITableViewDataSource**にある，2つ目の関数を以下のように改変します．

``` swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
    cell.accessoryType = .disclosureIndicator
    cell.textLabel?.text = beaconData[indexPath.row].name
    cell.detailTextLabel?.text = "\(beaconData[indexPath.row].info.uuid)"
    return cell
}
```

cell内の**textLabel**の内容，**detailLabel**の内容を更新する処理を追加しました．これで再度ビルドすると，以下のような表示になります．

![](README_image/33.jpeg)

BeaconData.jsonに入れていた情報をもとに，TableViewCellに表示する情報を変えることができました．これでBeaconListViewControllerの表示内容の実装は完了です．

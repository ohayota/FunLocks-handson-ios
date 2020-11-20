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
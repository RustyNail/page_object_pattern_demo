# はじめに

前半は、Seleniumの入門としてSelenium/Capybaraを使ったテストについて説明します。
後半では、テストのメンテナンス効率をあげるための技法「ページオブジェクトデザインパターン」の習得を目指し、
既存のコードに適用していきます。

# チュートリアルで用意されているテストについて

## テストで使用するサイト

日本Seleniumユーザーコミュニティのテスト用サイトを使用します。

- ホテル宿泊予約サイト : http://example.selenium.jp/reserveApp_Renewal/
- 詳細は[こちら](https://sites.google.com/site/seleniumjp/test-site)

## テストで使用するライブラリ

- rspec
  - Rubyのテストフレームワーク
- selenium-webdriver
  - Webアプリケーションのテスト自動化をサポートするツール
- capybara
  - WebアプリケーションのE2Eテストフレームワーク
- site_prism
  - ページオブジェクトデザインパターンのテストの作成をサポートする
  - Gemfileには設定済みですが、演習でのコーディングを想定しているため該当するコードはありません

## テストで使用するブラウザ

ブラウザはHeadless Chromeを使用します。

## テストの実行方法

Docker環境でテストを実行します。

- ビルド
  - `docker-compose build`
- テスト実行
  - `docker-compose run --rm test`

## 補足

### 特定のテストを実行

実行したいテストにフォーカスを当てると単体で実行できます。
Ex) `fdescribe`, `fcontext`

### Capybaraのhostに設定済み
http://example.selenium.jp をホストに設定しているため、相対パスでアクセスできます。

### スクリーンショットの取得

以下のコマンドでスクリーンショットを取得できます。
Ex) `page.save_screenshot 'xxx.png'`

### rubocopを実行

以下のコマンドでrubocopを実行できます。
`docker-compose run --rm test bundle ex rubocop`

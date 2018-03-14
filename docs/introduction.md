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

ライブラリ|概要|公式サイト|ドキュメント
---|---|---|---
RSpec|Rubyのテストフレームワーク|[RSpec: Behaviour Driven Development for Ruby](http://rspec.info/)|http://rspec.info/documentation/ https://relishapp.com/rspec
Selenium WebDriver|Webアプリケーションのテスト自動化をサポートするツール|[Selenium WebDriver](https://www.seleniumhq.org/projects/webdriver/)|https://github.com/SeleniumHQ/selenium/wiki/Ruby-Bindings http://seleniumhq.github.io/selenium/docs/api/rb/index.html
Capybara|WebアプリケーションのE2Eテストフレームワーク|[Capybara](http://teamcapybara.github.io/capybara/)|http://www.rubydoc.info/github/teamcapybara/capybara/master
SitePrism|ページオブジェクトデザインパターンのテストの作成をサポートする|[natritmeyer/site_prism: A Page Object Model DSL for Capybara](https://github.com/natritmeyer/site_prism)|http://www.rubydoc.info/gems/site_prism/frames

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

`describe|context|it` の先頭に `f` を付けることにより、特定の `it|describe|context|it` を実行できます
- Ex) `fdescribe`, `fcontext`, `fit`

### Capybara.app_host にテスト用サイトのスキーマ、ホスト名 http://example.selenium.jp/ を指定

テスト対象のサイトへは `visit '/reserveApp_Renewal/'` のようにパスのみでもアクセスできます

### スクリーンショットの取得

テストスクリプトに以下を加えるとスクリーンショットを取得できます。
- Ex) `page.save_screenshot 'xxx.png'`

### rubocopを実行

以下のコマンドでrubocopを実行できます。
- `docker-compose run --rm test bundle ex rubocop`

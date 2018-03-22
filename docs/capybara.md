# Capybara

WebアプリケーションのE2EテストフレームワークであるCapybaraについて解説します。

## Capybaraの利点

### Implicit Wait

Capybaraは、次のようなImplicit Wait (暗黙的な待機)の仕組みがあります。

`Kernel.#sleep` や `Selenium::WebDriver::Wait` のような明示的な待機処理を書く必要がなく、Javascriptによる動的な画面上の要素変更に簡単に対応することができます。

- 要素が見つかるまで待機
- Matcherが成功するまで待機

CapybaraのImplicit Waitのデフォルトの時間は2秒です。
デフォルトの時間以外に変更する場合 `Capybara.using_wait_time(sec)` を利用します。

### 豊富な要素操作メソッド

Capybaraでは、次のような要素を便利に操作するためのメソッドが利用できます。

- テキスト
  - `Capybara::Node::Actions#fill_in`
    - 例: `page.fill_in 'Name', with: 'foobar'`
- プルダウン
  - `Capybara::Node::Actions#select`
    - 例: `page.select 'Group 1', from: 'groups'`
- チェックボックス
  - `Capybara::Node::Actions#check`
    - 例: `page.check 'Accept'`
- ラジオボタン
  - `Capybara::Node::Actions#choose`
    - 例: `page.choose 'Yes'`

### 豊富なMatchers

Capybaradには、RSpecのexpectメソッドと組み合わせて使えるいくつかのメソッドがあります。

- [Module: Capybara::RSpecMatchers — Documentation for jnicklas/capybara (master)](http://www.rubydoc.info/github/jnicklas/capybara/Capybara/RSpecMatchers)
  - `have_css`
    - 例: `it { expect(page).to have_css('form#account') }`
  - `have_content`
  - `have_text`
    - 例: `it { expect(page.find('label[for="Name"]')).to have_text('foobar') }`

## 参考文献

- [Selenium実践入門 ―― 自動化による継続的なブラウザテスト (WEB+DB PRESS plus)](https://www.amazon.co.jp/dp/4774178942)

# Capybara

WebアプリケーションのE2EテストフレームワークであるCapybaraについて解説します。

## Capybaraの利点

### Implicit Wait

Capybaraは、次のようなImplicit Wait (暗黙的な待機)の仕組みがあります。

- 要素が見つかるまで待機
- Matcherが成功するまで待機

CapybaraのImplicit Waitのデフォルトの時間は2秒です。
デフォルトの時間以外に変更する場合 `Capybara.using_wait_time(sec)` を利用します。

`Kernel.#sleep` や `Selenium::WebDriver::Wait` のような明示的な待機処理を書く必要がないため、画面上の要素変更にも簡単に対応することができます。

### 豊富な要素操作メソッド

- テキスト/プルダウン/チェックボックス/ラジオボタン

### 豊富なMatchers

- [Module: Capybara::RSpecMatchers — Documentation for jnicklas/capybara (master)](http://www.rubydoc.info/github/jnicklas/capybara/Capybara/RSpecMatchers)
- have_cssなど

## 参考文献

- [Selenium実践入門 ―― 自動化による継続的なブラウザテスト (WEB+DB PRESS plus)](https://www.amazon.co.jp/dp/4774178942)

# はじめに

既存のテストをいくつかの演習を進めながらページオブジェクトデザインパターンテストに変更していきます。

Googleの検索サイト (https://www.google.co.jp/) をテストサイトとした以下のサンプルコードを参考にして進めてください。

```ruby
## Page Object
class Google < SitePrism::Page
  set_url 'https://www.google.co.jp/'

  element :search_field, '[name="q"]'
  element :search_button, '[name="btnK"]'

  def search(value = '')
    search_field.set value
    search_button.click
  end
end

class GoogleSearchResult < SitePrism::Page
  set_url_matcher %r{https://www.google.co.jp/search\?.*}

  element :search_field, '[name="q"]'
end

## Test Code
let(:google) { Google.new }
before { google.load }
subject { google.search 'site_prism' }
example do
  subject
  expect(GoogleSearchResult.new).to be_displayed & be_all_there
end
```

## 解説

#### ページのURLの定義

- ページオブジェクト
  - `set_url` または `set_url_matcher` を定義します
    - `Capybara.app_host` を設定しておくとパスのみでのアクセスもできます
- テストコード
  - `load` でページのロードができ、 `be_displayed` でページが表示されていることを検証することができます

#### ページ内に存在する要素の定義

- ページオブジェクト
  - `element` または `elements` を定義します
    - 要素が複数存在する場合は `elements` を使用します
    - セレクタの指定はデフォルトではCSSですが、 `element :search_field, :xpath, '//*[@id="lst-ib"]'` のようにxpathでの指定もできます
- テストコード
  - `be_all_there` で定義したすべての要素を一括で検証することもできます
    - `have_[element名]` で指定した要素のみの検証もできます

#### ページとセクション

`Page (SitePrism::Page)` はページオブジェクトを定義したものです。

`Section (SitePrism::Section)` は一覧ページ等で複数回登場するようなまとまりを定義できます。

複数登場しない場合でも一定のまとまりがあれば、 `Section` としておくと読みやすさが向上します。

Ex)

```ruby
class Hoge < SitePrism::Page
  section :menu, MenuSection, "#menu"
end

class MenuSection < SitePrism::Section
  element :ele1, '#ele1'
  element :ele2, '#ele2'
  element :ele3, '#ele3'
end
```

# [演習1] 予約フォームのページオブジェクトを作成しましょう

`spec/pages/` 以下にページオブジェクトを定義するファイルを作成しましょう。

- `Page` の作成
- `set_url` の定義
- `element` の定義

# [演習2] 作成したページオブジェクトを利用するためにテストを修正しましょう

`spec/reservation_spec.rb` の1つ目のテストコードを修正しましょう。

```ruby
describe 'visiting reservation form page' do
  context 'when visiting reservation form' do
```

# [演習3] ページオブジェクトにメソッドを定義しましょう

ページオブジェクトにメソッドを定義して、以下のテストコードを修正しましょう。

```ruby
describe 'visiting reservation form page' do
  ## Use capybara
  context 'when click on brand button' do
```

# [演習4] 期待通りに動かないテストへのアプローチ

Seleniumを使ったテストでは書いているコードは正しそうなのに期待通りに動作しないということがあります。

原因を見つけてテストが成功するようにテストコードを修正しましょう。

```ruby
xdescribe 'inputting reservation information' do
```

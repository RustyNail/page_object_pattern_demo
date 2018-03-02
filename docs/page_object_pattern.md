# ページオブジェクトパターンとは

ページオブジェクトパターンの概略を説明する。

## 目的

- 冗長なコードを減らす
- 変更に強いテストコードにする
  - 呼び出し元は、ページが提供するサービスを記述しHTML構造を隠蔽する

## 概要

<img width="960" alt="default" src="https://user-images.githubusercontent.com/1730234/36888625-a95b6a72-1e39-11e8-86a8-bfdd91fec480.png">

- パブリックメソッドは、ページが提供するサービスを表す
- ページの内部を公開しない
- 一般的にアサーションを作成しない
- ページ全体を表現する必要は無い

## 実装

- メソッドが他のPageObjectを返さない
- メソッドが他のPageObjectを返す
  - ページ遷移を伴わない場合は自身のPageObjectを返す ([SeleniumHQ公式Wikiの場合](https://github.com/SeleniumHQ/selenium/wiki/PageObjects))
  - ページ遷移を伴わず、文字列等を返さない場合はvoidを返す ([Selenium実践入門の場合](https://www.amazon.co.jp/dp/4774178942))

方法|特徴
-|-
メソッドが他のPageObjectを返さない|同じアクションを単一メソッドにできるが、ページ遷移の結果を呼び出し元に書く必要がある
メソッドが他のPageObjectを返す|ページ遷移の結果が異なるアクションは異なるメソッドにする必要がある
ページ遷移を伴わない場合は自身のPageObjectを返す|一貫してアクションをメソッドチェーンで書くことができる
ページ遷移を伴わず、文字列等を返さない場合はvoidを返す|ページ遷移を伴うアクションをメソッドチェーンで書くことができる

## 参考

- [PageObjects · SeleniumHQ/selenium  @Wiki](https://github.com/SeleniumHQ/selenium/wiki/PageObjects)
- [PageObjectパターンではメソッドの返り値をどうするのが良いのか | ひびテク](https://yoshikiito.net/blog/archives/951)

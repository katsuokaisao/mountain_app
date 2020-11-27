#### README

## 100名山
***

https://www.mountain-app.com/

## サイト概要
***
このアプリでは山と人の交流を深めるをコンセプトにした山日記アプリです。

1. 登山に行った記録を残したいけど
2. ただ記録を残したいだけでなく、Twitterのように気軽にシェアしたい
3. 登山をしている人ともっとカジュアルにつながりたい

という方に向いています。  
現状、山の記録を残せるアプリがありますが自分の記録を正確に残したり、登山する前にコースを決めるために他の人の記録を参考にしたりする用途に特化しているように感じました。そこでもっとフランクに情報を共有できて人の交流に特化したアプリを作成したいという経緯からこちらのアプリを作成致しました。

## 使用技術
***
- 開発環境(Docker, Docker-compose, Nginx, Unicorn, MySQL)
- Docker Desktop for Mac
- VSCode
- Rails 6.0.3
- Ruby 2.6.6
- Rubocop
- Rspec, FactoryBot, Capybara
- JS(webpacker)
- html, scss(sprocekts)
- MySQL 8.0
- ソース管理(Cit, GitHub)
- AWS(EC2, ALB, Route53, ACM, RDS, S3)
- CircleCI(CI/CD)
  - CIはmasterブランチにpushもしくはマージ後にRubocopとRspecを行う
  - CDはCircleCIでEC2にssh接続してgit pull等を行う

## 機能一覧
***
- ユーザー登録・ログイン(Devise)
- 管理ユーザー(ActiveAdmin)
- 画像アップロード（ActiveStorage)
- 日記投稿の複数画像プレビュー機能
- 画像拡大表示(lightbox2-rails)
- ページネーション(kaminari)
- 無限スクロール（kaminari+jscroll)
- 地図表示(Maps JavaScript API)
- N+1(bullet)
- バリデーションの日本語対応(rails-i18n)
- 登山日記作成・削除・一覧・詳細機能
- フォロー機能(ajax)
- いいね機能(ajax)
- コメント機能
- 通知機能（フォロー・いいね・コメント）
- 山一覧絞り込み機能(ransack)
- DM機能（予定）
- 大まかなレスポンシィブ対応
- サイドバーの設置  
  （768px以下でモーダルウィンドウに設置）

## 工夫点
***

- テストの自動化により網羅的に効率よくエラーの検知を行えるようにしている点
- 一部ajax化に取り組んでいる点
- CSSフレームワークを用いずに素のCSSを用いることでコードの修正がしやすくしている点
- 複数画像のプレビュー機能とドロップラウンメニューのJSでの実装
- ナビゲーションを左にも配置することで可視性の向上に取り組んでいる点
- N+1問題の解消してページの表示スピードの遅延防止に取り組んでいる点
- 画像投稿にActiveStorageを用いている点
- 開発環境でDockerを採用して開発環境構築をコード化している点
- 本番環境でCircleCIを採用して自動テスト・自動デプロイを実装している点

## インフラ構成図
***
![aws構成図完成版-ページ2](https://user-images.githubusercontent.com/56217789/100398945-2771e200-3094-11eb-94f6-ccd4ad2edee7.jpg)

## DB設計
***
![erd](https://user-images.githubusercontent.com/56217789/100403078-327f3f00-30a1-11eb-8e79-85e636fce3a2.jpeg)


## 改善・気になっている点
***

- デザインが不十分
- 機能に独自性がない・機能が不十分
- フロントにモダンなフレームワークを使っていない
- リファクタリングが不十分、コードに無駄がある
- 命名に不適切な点がある(日記を表すdialyをdailyと間違えてしまった点や英単語の複数形を間違えてしまった点)
- インフラのコード化に取り組めていない
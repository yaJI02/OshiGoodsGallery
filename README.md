# 💘推しグッズギャラリー💘
## ■サービスURL
2024年5月3日（金）をもってサービスを終了しました。
## ■サービス概要
自分の推しグッズや保管方法などをみんなで共有するアプリです🫰

## ■ このサービスへの思い
推しがいると、人生が変わる。

これは著名人の名言…ではなくただの私論です。  
しかし、私は、辛いとき・疲れている時でも、推しのことを考えると前向きな気持ちになれます。  
そんな推しを応援する方法の一つとしてグッズを集めているのですが、そんな時に下記のような思いを持ちました。

- 自分のグッズの写真を記録して、グッズを通して推し活の思い出を振り返りたい！
- 同じ趣味の人のグッズを見て情報を集めたい＆癒されたい！
- グッズの飾り方やアレンジ方法をみんなに見てもらいたい、他の人のアイデアを参考にしたい！

そんなときに使えるアプリがあったら楽しいぞ！と思い、本アプリを考案しました。

## ■ ユーザー層について
1. 推しがいるすべての人
1. 人とアイデア・情報を共有するのが好きな人

## ■サービスの利用イメージ
- グッズ情報の投稿・閲覧
  予約したグッズを記録して備忘録に使える
  同じ趣味を持つ仲間と出会える  
  情報収集し、グッズ購入の参考にできる

- グッズの収納方法・飾り方・アレンジ方法などのアイデアを投稿・閲覧  
  アイデアの発信や新たな発想を入手できる

- お気に入りの投稿をマイリストに追加  
  グッズやアレンジ用アイテムを購入する時にすぐに確認できる

- 投稿にいいねなどのリアクション／自分の投稿をsnsでシェア  
  同じ趣味を持つ仲間と交流できる

## ■ ユーザーの獲得について
sns投稿機能を実装し、それをユーザーが使うことで同じ趣味を持つフォロワーに知ってもらえる確率を増加させます。

## ■ サービスの差別化ポイント
- グッズに特化したサービスである
- グッズの金額や購入場所を記録できる欄を追加し、より閲覧者の参考になる情報を増やす
- タグ機能を充実させ、欲しい情報を閲覧しやすくする
- 「地雷」タグを設定することで、自分の見たくない情報を閲覧しないで済む機能を作る

## ■ 機能候補
### MVPリリース機能
- ユーザーログイン機能
- グッズおよびアイデア投稿機能
- トップページ
- マイページ
### 本リリース機能
- タイトル・本文・タグでの検索機能(マルチ検索オートコンプリート )
- マイリスト機能
- googleログイン
- sns共有
- いいね機能
- タグによる地雷避け機能
- いいね数によるランキング機能
- コメント機能
- フォロー機能
- 通知機能

## ■ 機能の実装方針予定
### トップページ
- ヘッダー
    - アプリ名
    - ログインボタン
    - 新規登録ボタン
- みんなの投稿（（スライドショー形式・クリックで投稿へリンク）
    - ランキング
    - 新着グッズ投稿（１０件まで）
    - 新着ショールーム投稿（１０件まで）
- 投稿一覧への推移ボタン
- フッター
    - このアプリでできること/お問い合わせ
    - 利用規約
    - プライバシーポリシー

### 投稿一覧ページ
- 検索機能
    - グッズもしくはショールーム
    - タイトル
    - カテゴリ
    - タグ検索（推しポイント・コンテンツカテゴリ・グッズカテゴリ）
    - フリー検索（推しポイント・コンテンツカテゴリ・コメント・購入場所・グッズカテゴリ）
- いいね機能（登録必須、ここはいいねのみ）

### 詳細・新規（登録必須）・編集（登録必須）画面
- 投稿内容表示
- いいね機能（登録必須、全てのスタンプ）
- お気に入りリスト登録（登録必須）
- コメント機能（登録必須、コメントオフ機能）
- X(Twitter)投稿（登録必須、自分の投稿のみ）  
  X(Twitter)API  
  「タイトル」  
  「コメント」  
  タグは全てハッシュタグに変換  
  推しグッズギャラリーのURL
- 共有機能（urlをクリップボードにコピー）

### **会員登録・ログイン画面**
- 新規ユーザー登録
- ログイン
- googleログイン  
  Google Cloud Platform（API）

### プロフィール登録・編集画面（登録必須）
- 必須：アイコン（デフォルトもしくはアップロード）
- 必須：ニックネーム
- snsアカウント
- 推しコンテンツタグ
- 自分のお気に入り投稿
- 地雷フィルター（全て表示・お気に入りタグのみ表示・地雷タグを表示しない）
  - お気に入りタグ（自分が投稿したタグは自動追加）
  - 地雷タグ

### マイページ（登録必須）
- プロフィール詳細を表示・編集へのリンク
- いいねされた数
- 使ったお金の累計数（予約を含む・含まない）
- 自分の投稿一覧（検索）
- いいねした投稿一覧（検索）
- お気に入り登録一覧（検索）  
  タイトルとサムネと金額
- 通知機能
  いいね・コメントされたら通知

## 画面遷移図
https://www.figma.com/file/TZehx3NGEY5foaN2WVstSt/OshiGoodsGallery?type=design&node-id=0%3A1&mode=design&t=zHPFYymOQaDZJAKw-1

## ER図
![Test Image 1](ERD.drawio.png)

## 環境構築
1.Dockerイメージのビルド  
```docker compose build```  
2.バックグラウンドでのDockerコンテナ立ち上げ・railsサーバー起動  
```docker compose up -d```  
3.コンテナに入る  
```docker compose exec web bash```  
4.コンテナ内でバンドルインストール  
```bundle install```  
5.コンテナ内でDBの作成  
```bin/rails db:create```  

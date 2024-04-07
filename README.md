# サービス名: Syukan-meter

## ■サービス概要
どんなサービスなのかを３行で説明してください。
- 習慣を作成、記録、共有できるアプリ。
- 習慣にしたい時間に通知を行う。ポモドーロタイマーで時間を計測し、作業時間と休憩時間を交互に通知する。ポモドーロの回数に伴いその日どのくらい行ったかをカレンダーに記録できる。
- 軽いアウトプットやメモ、共有、応援や意見交換を行えるTwitter（Post機能）の学習版みたいなもの

## ■ このサービスへの思い・作りたい理由
- 学習習慣を作るきっかけになればと考えました。さらにポモドーロタイマーで時間を区切り集中と休憩の切り替えをスムーズに。
- どのくらい頑張ったかなどカレンダーに可視化されればやる気の継続につながるとかんがえました。

- 自分自身がプログラミング学習を行っていく中で習慣化がなかなか難しく、うまく集中できなかったり時にサボってしまったりなどモチベーションの上がり下がりなどがありました。習慣化について調べていく中でポモドーロ法で時間を区切って集中と休憩を繰り返すことで作業を効率的に進められること、アウトプットで学習の理解度を図ることや頑張りを共有することでモチベーションを維持できること、GitHubで草を生やしていくことで視覚的に頑張りが確認できるなどが習慣化に貢献してくれました。これらを一つにまとまることで違うアプリを開いたりすることなくシンプルにできるのではないかと考えこのアプリを作成しようと考えました。
- githubに草を生やす＋共有＋ポモドーロによる時間の区切りが一緒にできれば更に良いと考えた。

## ■ 機能紹介
|トップ画面|LINEログイン、LINEユーザー作成|
|:-:|:-:|
|image|image|
|メイン機能の説明、まずは機能のイメージが分かるようにタイマーページと投稿機能へのリンクを設置しています。|ユーザー登録とログインを楽に行えるようにLINEログインをなるべく目立つように配置しました|


|習慣作成|習慣一覧|
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/11630c6ca21a8a37100b80e1cb065566.png)](https://gyazo.com/11630c6ca21a8a37100b80e1cb065566)|[![Image from Gyazo](https://i.gyazo.com/5270c85dbc78b422ef2693f76d861a0a.gif)](https://gyazo.com/5270c85dbc78b422ef2693f76d861a0a)|
|作成フォームをモーダル表示にすることで無駄な遷移なく入力できるようにしています。|作成した習慣が表示されます。期間内と期間外に分けることで現在何を習慣にしているかわかりやすいようにしています。|

|ポモドーロタイマー機能|習慣通知機能|
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/a745f6f96eb679143f1938960f34bb4a.png)](https://gyazo.com/a745f6f96eb679143f1938960f34bb4a)|[![Image from Gyazo](https://i.gyazo.com/0033934afe21e6cf94f82ea5ae30a83b.jpg)](https://gyazo.com/0033934afe21e6cf94f82ea5ae30a83b)|
|25分と5分を繰り返すタイマーです。別ページに遷移してもリセットされないようにしました。25分タイマーが終了した際にポップアップすることで投稿促しています。またカレンダーに記録されるようになっています。|習慣の日付が範囲内なら設定した通知時間にLINEプッシュ通知を行います。|


|投稿機能|カレンダー機能|
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/5296c1f11f526aa5a9a1641cd5bf7d45.gif)](https://gyazo.com/5296c1f11f526aa5a9a1641cd5bf7d45)|[![Image from Gyazo](https://i.gyazo.com/a26f5d0fc0360b004690f51bc673b1b3.png)](https://gyazo.com/a26f5d0fc0360b004690f51bc673b1b3)|
|いいね機能と詳細からは投稿に対しコメント機能を設け、交流を促すことでモチベーション維持を促しています|作成した習慣、進捗、当日行ったポモドーロタイマー回数を記録しています。振り返ることでモチベーション維持を促しています。進捗機能に関しては当日のみ操作できるようにしています。|


## ■ 技術構成
使用技術
|カテゴリ|技術|
|:-:|:-:|
|フロントエンド|Rails 7.0.8(Hotwire/Turbo),TailwindCSS|
|バックエンド|Rails 7.0.8(Ruby 3.1.4)|
|データベース|PostgreSQL|
|インフラ|Heroku|
|画像保存|AWS(S3)|

## ■ ER図

### 画面遷移図(README作成時のままです)
Figma：https://www.figma.com/file/17rbqZ5d37uVrkW0q8JQbZ/Syukan_Maker?type=design&mode=design&t=1LiRTtLKKlfjEjtu-

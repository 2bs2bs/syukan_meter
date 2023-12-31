# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# syukan_meter
## ■サービス概要
どんなサービスなのかを３行で説明してください。
- 習慣を作成、記録、共有できるアプリ。
- 習慣にしたい時間に通知を行う。ポモドーロタイマーで時間を計測し、作業時間と休憩時間を交互に通知する。ポモドーロの回数に伴いその日どのくらい行ったかをカレンダーに記録できる。
- 軽いアウトプットやメモ、共有、応援や意見交換を行えるTwitter（Post機能）の学習版みたいなもの

## ■ このサービスへの思い・作りたい理由
このサービスの題材となるものに関してのエピソードがあれば詳しく教えてください。
- 学習習慣を作るきっかけになればと考えました。さらにポモドーロタイマーで時間を区切り集中と休憩の切り替えをスムーズに。
- どのくらい頑張ったかなどカレンダーに可視化されればやる気の継続につながるとかんがえました。

- 自分自身がプログラミング学習を行っていく中で習慣化がなかなか難しく、うまく集中できなかったり時にサボってしまったりなどモチベーションの上がり下がりなどがありました。習慣化について調べていく中でポモドーロ法で時間を区切って集中と休憩を繰り返すことで作業を効率的に進められること、アウトプットで学習の理解度を図ることや頑張りを共有することでモチベーションを維持できること、GitHubで草を生やしていくことで視覚的に頑張りが確認できるなどが習慣化に貢献してくれました。これらを一つにまとまることで違うアプリを開いたりすることなくシンプルにできるのではないかと考えこのアプリを作成しようと考えました。

このサービスを思いつくにあたって元となる思いがあれば詳しく教えてください。
- githubに草を生やす＋共有＋ポモドーロによる時間の区切りが一緒にできれば更に良いと考えた。

## ■ ユーザー層について
決めたユーザー層についてどうしてその層を対象にしたのかそれぞれ理由を教えてください。
- 主に学習継続を目的にしている方、その中でも長期間の学習を継続したい方をターゲットにしました。学習継続だけでなく、なにかPC作業など継続したいことがある方の作業への集中や習慣化の手助けを目的にしています。(イメージとしてですが、小説や日記、楽曲作成、プログラミング、ブログなど)
- 誰かと一緒に学習をしたい方→投稿機能(Twitterのような投稿機能)で今日頑張ったことや学習のアウトプットを行える。いいね機能で頑張りを応援できる。コメント機能で交流が図れる。
- 自分もPG学習を行っている傍ら習慣づけることがなかなか難しかったので一助になればと考え同じ学習を行っている方をターゲットにしました。

## ■サービスの利用イメージ
ユーザーがこのサービスをどのように利用できて、それによってどんな価値を得られるかを簡単に説明してください。
- 習慣化の一助となってやる気やモチベーションの維持向上を行えることができる。
- ポモドーロで時間を区切ることで学習のスイッチを作ることができる

## ■ ユーザーの獲得について
想定したユーザー層に対してそれぞれどのようにサービスを届けるのか現状考えていることがあれば教えてください。
- まずはRUNTEQ生の方々に使っていただいて学習継続を習慣にしていただけたらと考えています。

## ■ サービスの差別化ポイント・推しポイント
似たようなサービスが存在する場合、そのサービスとの明確な差別化ポイントとその差別化ポイントのどこが優れているのか教えてください。
独自性の強いサービスの場合、このサービスの推しとなるポイントを教えてください。
- 交流を図るなどのポイントはTwitterなどとかぶるかもしれませんがどのくらい継続しているかなどがカレンダーに記録される、ポモドーロタイマーなどが一つにまとまっていることで別のアプリを開いたりする手間が減ることが差別化できるポイントになるかと思います。

## ■ 機能候補
現状作ろうと思っている機能、案段階の機能をしっかりと固まっていなくても構わないのでMVPリリース時に作っていたいもの、本リリースまでに作っていたいものをそれぞれ分けて教えてください。
- 習慣をuserが自由に設定できる機能(カテゴリ機能)
- ユーザーが設定した時間に通知(リマインダー機能)
- ポモドーロタイマーの設定
- ポモドーロを使用した回数でどのくらい頑張ったか視覚できるカレンダー機能
- 共有や交流できる投稿機能、いいね機能、コメント機能
- login機能、logout機能

## ■ 機能の実装方針予定
一般的なCRUD以外の実装予定の機能についてそれぞれどのようなイメージ(使用するAPIや)で実装する予定なのか現状考えているもので良いので教えて下さい。
- 通知機能に関してはLINE通知を想定しています。習慣の決まった時間とポモドーロの終了通知など
- simple_calenderを使ったカレンダー機能
- 投稿機能、いいね機能、コメント機能はカリキュラムで作ったものを参考に作成しようと考えています。

## ■ 今後実装しようとしようか検討している機能
- タグ機能
- 検索機能(投稿している内容、コメント、ユーザー)
- タイマー機能に関して
  - ポモドーロテクニック
  - カスタマイズ可能な時間設定
  - 進捗バー
  - 統計情報
  - 音楽を入れる

### 画面遷移図
Figma：https://www.figma.com/file/17rbqZ5d37uVrkW0q8JQbZ/Syukan_Maker?type=design&mode=design&t=1LiRTtLKKlfjEjtu-1

### pullrequestを分けるための記載

class UserNotifyJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # LINE Botクライアントの設定
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_MESSAGE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_MESSAGE_CHANNEL_TOKEN"]
    }

    # ユーザーに送信するメッセージを定義する
    message = {
      type: 'text',
      text: "#{habit.name}の時間が来ました！ポモドーロを回しましょう！"
    }

    # ユーザーIDを使用してメッセージを送信する
    response = client.push_message("", message)

    # debug
    puts response.body
  end
end

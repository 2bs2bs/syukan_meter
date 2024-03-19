require 'line/bot'

class SendLineMessageJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # メッセージ内容
    message = {
      type: 'text',
      text: '今日も一日頑張ろう！'
    }

    # user_id = 実際のuser_id
    user_uid = Profile.find_by(user_name: "つばさ").user.authentications.pluck(:uid).first
    response = line_client.push_message(user_uid, message)

    # debug
    puts response.body
  end

  private

  def line_client
    Line::Bot::Client.new{ |config|
      config.channel_secret = ENV["LINE_MESSAGING_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_MESSAGING_CHANNEL_TOKEN"]
    }
  end
end

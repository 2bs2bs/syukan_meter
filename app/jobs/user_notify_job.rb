require 'line/bot'

class UserNotifyJob < ApplicationJob
  queue_as :default

  def perform(*args)
    my_uid = ENV["MY_LINE_UID"]

    message = {
      type: 'text',
      text: 'テストメッセージ'
    }

    response = line_client.push_message(my_uid, message)

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

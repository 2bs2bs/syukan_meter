require 'line/bot'

class SendLineMessageJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # habits = Habit.all
    current_hour = Time.current.hour
    habits = Habit.where(notification_time: current_hour).includes(:user)
    target_date = Date.today
    
    habits.each do |habit|
      date_range = habit.start_date..habit.end_date # 範囲内かどうか
      notification_time = habit.notification_time

      if date_range.cover?(target_date) && notification_time == current_hour
        # メッセージ内容
        message = {
          type: 'text',
          text: "#{habit.name}の時間になりました！頑張りましょう！"
        }

        # LINE通知ロジック
        user_uid = habit.user.authentications.find_by(provider: "line").uid
        response = line_client.push_message(user_uid, message)

        # debug
        puts response.body
      end
    end
  end

  private

  def line_client
    Line::Bot::Client.new{ |config|
      config.channel_secret = ENV["LINE_MESSAGING_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_MESSAGING_CHANNEL_TOKEN"]
    }
  end
end

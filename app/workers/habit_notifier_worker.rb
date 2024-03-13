class HabitNotifierWorker
  include Sidekiq::Worker

  def perform(habit_id)
    habit = Habit.find(habit_id)
    user = habit.user
    message = "【習慣通知】#{habit.name}の時間です！"

    client = Rails.application.config.line_bot_client
    response = client.push_message(user.line_user_id, { type: 'text', text: message })

    unless response.success?
      Rails.logger.error "Failed to send LINE message: #{response.body}"
    end
  end
end
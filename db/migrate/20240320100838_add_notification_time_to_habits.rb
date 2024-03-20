class AddNotificationTimeToHabits < ActiveRecord::Migration[7.0]
  def change
    add_column :habits, :notification_time, :integer
  end
end

class RemoveColumnsFromPomodoros < ActiveRecord::Migration[7.0]
  def change
    remove_column :pomodoros, :duration, :integer
    remove_column :pomodoros, :status, :string
    remove_column :pomodoros, :type, :string
  end
end

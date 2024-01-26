class RenameGoalToEndDateInHabits < ActiveRecord::Migration[7.0]
  def change
    rename_column :habits, :goal, :end_date
  end
end

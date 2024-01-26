class RemoveOldEndDateFromHabits < ActiveRecord::Migration[7.0]
  def change
    remove_column :habits, :end_date, :integer
    rename_column :habits, :new_end_date, :end_date
  end
end

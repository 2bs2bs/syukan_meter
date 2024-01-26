class AddNewEndDateToHabits < ActiveRecord::Migration[7.0]
  def change
    add_column :habits, :new_end_date, :date
  end
end

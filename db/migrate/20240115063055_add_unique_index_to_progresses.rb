class AddUniqueIndexToProgresses < ActiveRecord::Migration[7.0]
  def change
    add_index :progresses, [:habit_id, :date], unique: true
  end
end

class CreateProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :progresses do |t|
      t.references :habit, null: false, foreign_key: true
      t.date :date
      t.boolean :completed

      t.timestamps
    end
  end
end

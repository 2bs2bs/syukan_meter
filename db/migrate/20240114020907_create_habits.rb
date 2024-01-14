class CreateHabits < ActiveRecord::Migration[7.0]
  def change
    create_table :habits do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.integer :goal
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreatePomodoros < ActiveRecord::Migration[7.0]
  def change
    create_table :pomodoros do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :duration
      t.integer :status
      t.string :type
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end

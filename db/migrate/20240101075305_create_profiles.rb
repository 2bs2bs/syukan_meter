class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :user_name
      t.string :avatar
      t.string :introduction
      t.string :social_link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

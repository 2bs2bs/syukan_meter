class AddCounterCachesToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :comments_count, :integer, default: 0, null: false
    add_column :posts, :bookmarks_count, :integer, default: 0, null: false
  end
end


class User < ApplicationRecord
  authenticates_with_sorcery!
  
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, presence: true, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post

  accepts_nested_attributes_for :profile

  def own?(object)
    id == object&.user_id
  end

  def bookmark(post)
    bookmark_posts << post
  end

  def unbookmark(post)
    bookmark_posts.destroy(post)
  end

  def bookmark?(post)
    bookmark_posts.include?(post)
  end
end

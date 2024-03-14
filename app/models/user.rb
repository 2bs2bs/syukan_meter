class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, presence: true, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post
  has_many :pomodoros, dependent: :destroy
  has_many :habits, dependent: :destroy
  has_many :progresses, through: :habits
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  accepts_nested_attributes_for :profile

  # LINELogginのための記載
  attr_accessor :temporary_name, :temporary_avatar
  before_save :assign_profile_attributes

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

  private

  def assign_profile_attributes
    build_profile unless profile
    profile.user_name = temporary_name if temporary_name
    profile.avatar = temporary_avatar if temporary_avatar
  end
end

class Profile < ApplicationRecord
  validates :user_name, presence: true
  mount_uploader :avatar, AvatarUploader

  belongs_to :user
end

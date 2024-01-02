class Profile < ApplicationRecord
  validates :user_name, presence: true
  belongs_to :user
end

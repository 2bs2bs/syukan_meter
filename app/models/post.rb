class Post < ApplicationRecord
  validates :body, presence: true, length: { maximum: 255 }

  belongs_to :user
  has_many :comments,  dependent: :destroy
  has_many :bookmarks, dependent: :destroy
end

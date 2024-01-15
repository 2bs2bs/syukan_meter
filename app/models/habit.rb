class Habit < ApplicationRecord
  # table_name: Habits
  # id
  # user_id:     references
  # name:        string
  # description: text
  # start_date:  date
  # goal:        integer
 
  belongs_to :user
  has_many :progresses, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 1000 }
  validates :start_date, presence: true
  validates :goal, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :start_date_cannot_be_in_the_past

  def active_on?(date)
    start_date <= date && date <= start_date + goal.days
  end

  def end_date
    start_date + goal.days 
  end

  private

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "can't be in the past") if start_date.present? && start_date < Date.today
  end
end

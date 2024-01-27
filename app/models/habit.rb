class Habit < ApplicationRecord
  # table_name: Habits
  # id
  # user_id:     references
  # name:        string
  # description: text
  # start_date:  date
  # end_date:    date
 
  belongs_to :user
  has_many :progresses, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 1000 }
  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :start_date_cannot_be_in_the_past, on: :create
  validate :start_date_cannot_be_before_creation, on: :update

  def active_on?(date)
    start_date <= date && date <= end_date
  end

  private

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "can't be in the past") if start_date.present? && start_date < Date.today
  end

  def start_date_cannot_be_before_creation
    if start_date.present? && persisted?
      original_habit = Habit.find(id)
      errors.add(:start_date, "can't be before the creation date") if start_date < original_habit.start_date
    end
  end
end

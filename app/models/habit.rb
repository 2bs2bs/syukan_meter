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
  validate :end_date_cannot_be_in_the_start_date
  validate :start_date_cannot_be_before_creation, on: :update

  def active_on?(date)
    start_date <= date && date <= end_date
  end

  private

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "当日以降を入力してください") if start_date.present? && start_date < Date.today
  end

  def end_date_cannot_be_in_the_start_date
    return if start_date.blank? || end_date.blank?

    errors.add(:end_date, "開始日以降を入力してください") if end_date.present? && end_date < start_date
  end

  def start_date_cannot_be_before_creation
    if start_date.present? && persisted?
      original_habit = Habit.find(id)
      errors.add(:start_date, "can't be before the creation date") if start_date < original_habit.start_date
    end
  end
end

class Progress < ApplicationRecord
  # table_name: progresses
  # id:
  # habit_id: references
  # date: date
  # completed: boolean

  belongs_to :habit
  has_one :user, through: :habits

  validates :date, presence: true
  validate :date_should_be_within_habit_range
  validates :completed, inclusion: { in: [true, false] }
  validates :date, uniqueness: { scope: :habit_id }

  private

  # 習慣の日付の範囲内でなければならない
  def date_should_be_within_habit_range
    if habit.present? && (date < habit.start_date || date > Date.today)
      errors.add(:date, "should be within the habit's start date and today")
    end
  end
end

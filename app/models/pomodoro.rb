class Pomodoro < ApplicationRecord
  # table_name: pomodoros
  #
  # id:
  # user_id:    references
  # duraction:  integer
  # status:     integer
  # type:       string
  # start_at:   datetime
  # end_at:     datetime
  # created_at: datetime
  # updated_at: datetime

  belongs_to :user
end

class CalendarsController < ApplicationController
  before_action :require_login

  def index
    @habits = current_user.habits.includes(:progresses)

    start_date = Date.today.beginning_of_month
    end_date = Date.today.end_of_month
    
    @pomodoros_by_day = current_user.pomodoros
                                    .where(created_at: start_date..end_date)
                                    .group_by { |pomodoro| pomodoro.created_at.to_date }
                                    .transform_values(&:count)
  end
end

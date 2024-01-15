class CalendarsController < ApplicationController
  def index
    @habits = current_user.habits.includes(:progresses)
  end
end

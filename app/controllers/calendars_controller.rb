class CalendarsController < ApplicationController
  before_action :require_login

  def index
    @habits = current_user.habits.includes(:progresses)
  end
end

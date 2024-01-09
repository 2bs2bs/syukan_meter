class PomodorosController < ApplicationController
  def index
    @pomodoros = current_user.pomodoros
  end
end

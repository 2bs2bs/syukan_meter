class PomodorosController < ApplicationController
  def index
    @pomodoros = pomodoro.new
  end
end

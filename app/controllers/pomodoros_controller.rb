class PomodorosController < ApplicationController
  def index
    @pomodoro = Pomodoro.new
  end
end

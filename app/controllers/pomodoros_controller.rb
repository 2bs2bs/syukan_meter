class PomodorosController < ApplicationController
  def index
    @pomodoro = Pomodoro.new
  end

  def create
    @pomodoro = Pomodoro.new(pomodoro_params)
    
    if @pomodoro.save
      render json: @pomodoro, status: :created
    else
      render json: @pomodoro.errors, status: :unprocessable_entity
    end
  end

  private

  def pomodoro_params
    params.require(:pomodoro).permit(:started_at, :ended_at)
  end
end

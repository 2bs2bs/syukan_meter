class ProgressesController < ApplicationController
  def create
    @habit = Habit.find(params[:habit_id])
    @progress = @habit.progresses.build(date: Date.today, completed: true)
    @progress.save
  end

  def delete
  end
end

class ProgressesController < ApplicationController
  def create
    @habit = Habit.find(params[:habit_id])
    @progress = @habit.progresses.build(date: Date.today, completed: true)
    @progress.save
  end

  def destroy
    @progress = current_user.progresses.find(params[:id])
    @habit = @progress.habit
    @progress.destroy
  end
end

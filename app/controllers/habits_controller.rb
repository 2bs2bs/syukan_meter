class HabitsController < ApplicationController
  before_action :require_login

  def index
    @habits = current_user.habits.order(created_at: :desc)
  end

  def show
    @habit = current_user.habits.find(params[:id])
  end

  def new
    @habit = current_user.habits.new
  end

  def create
    @habit = current_user.habits.build(habit_params)

    if @habit.save
      redirect_to habits_path, success: t('.success')
    else
      redirect_to habits_path, danger: t('.failure')
    end
  end

  def edit
    @habit = current_user.habits.find(params[:id])
  end

  def update
    @habit = current_user.habits.find(params[:id])

    if @habit.update(habit_params)
      redirect_to habits_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @habit = current_user.habits.find(params[:id])
    @habit.destroy
    redirect_to habits_path, success: t('.success')
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :description, :start_date, :end_date, :notification_time)
  end
end

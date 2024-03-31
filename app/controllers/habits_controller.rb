class HabitsController < ApplicationController
  before_action :require_login
  before_action :set_habit, only: [:show, :edit, :update, :destroy]

  def index
    @habits = current_user.habits.order(created_at: :desc)
  end

  def show; end

  def new
    @habit = current_user.habits.new
  end

  def create
    @habit = current_user.habits.build(habit_params)
    
    if @habit.save
      modal_option = current_user.authentications.present? ? {} : { modal: 'show' }
      redirect_to habits_path(modal_option), success: t('.success')
    else
      redirect_to habits_path, danger: t('.failure')
    end
  end

  def edit; end

  def update
    if @habit.update(habit_params)
      redirect_to habits_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @habit.destroy
    redirect_to habits_path, success: t('.success')
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :description, :start_date, :end_date, :notification_time)
  end

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end
end

class HabitsController < ApplicationController
  def index
    @habits = current_user.habits
  end

  def new
    @habit = current_user.habits.new
  end

  def create
    @habit = current_user.habits.build(habit_params)
    
    if @habit.save
      redirect_to habits_path, success: 'success habit create'
    else
      flash.now[danger] = 'failed habit create'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @habit = current_user.habits.find(params[:id])
  end

  def edit
    @habit = current_user.habits.find(params[:id])
  end

  def update
    @habit = current_user.habits.find(params[:id])
    
    if @habit.update(habit_params)
      redirect_to habits_path, success: 'update habit!'
    else
      flash.now[:danger] = 'faild update habit'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @habit = current_user.habits.find(params[:id])
    @habit.destroy
    redirect_to habits_path, success: 'habits deleted!'
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :description, :start_date, :goal)
  end
end

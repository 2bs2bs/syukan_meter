class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_profile, only: %i[edit update]

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to user_path(current_user), success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:user_name, :avatar, :introduction, :social_link)
  end
end

class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_profile, only: [:edit, :update]

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_path(current_user), success: 'profile update'
    else
      flash.now[danger] = 'profile edit filed'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:user_name, :avater, :introduction, :social_link)
  end
end

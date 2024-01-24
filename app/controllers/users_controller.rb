class UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      redirect_to home_path, notice: "user_create & login success"
    else
      flash.now[:danger] = 'user_create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.includes(:profile, posts: :bookmarks).find(params[:id])
    @bookmarked_posts = @user.bookmark_posts.includes(:bookmarks, user: :profile)
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, profile_attributes: [:user_name])
  end
end

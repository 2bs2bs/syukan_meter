class UsersController < ApplicationController
  def show
    @user = User.includes(:profile, posts: :bookmarks).find(params[:id])
    @bookmarked_posts = @user.bookmark_posts.includes(:bookmarks, user: :profile)
  end

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      redirect_to home_path, success: t('users.create.success')
    else
      flash.now[:danger] = t('users.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    if @user.update(user_params)
      redirect_to user_path(current_user.id), success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    if action_name == 'create'
      params.require(:user).permit(:name, :email, :password, :password_confirmation, profile_attributes: [:user_name])
    elsif action_name == 'update'
      params.require(:user).permit(:email)
    end
  end
end

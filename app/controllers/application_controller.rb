class ApplicationController < ActionController::Base
  add_flash_types :success, :danger

  private

  def require_login
    return if current_user

    not_authenticated
  end

  def not_authenticated
    redirect_to login_path, danger: 'ログインしてね！'
  end
end

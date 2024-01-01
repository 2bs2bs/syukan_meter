class ApplicationController < ActionController::Base
  add_flash_types :success, :danger

  private

  def require_login
    unless current_user
      not_authenticated
    end
  end

  def not_authenticated
    redirect_to login_path, danger: 'ログインしてね！'
  end
end

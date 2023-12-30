class ApplicationController < ActionController::Base
  add_flash_types :success, :danger

  private

  def not_authenticated
    redirect_to login_path, danger: 'ログインしてね！'
  end
end

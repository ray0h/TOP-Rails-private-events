class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  def require_login
    redirect_to login_path unless current_user
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    @current_user ||= User.friendly.find_by_id(session[:user_id])
  end

  helper_method :current_user

  def authenticate_user!
    redirect_to root_path, notice: "Please sign in" unless current_user
  end

  def verify_account!
    redirect_to root_path unless current_user.active == true
  end
end

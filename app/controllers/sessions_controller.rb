class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      # cookies.signed[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to root_path, alert: "Email or password incorrect"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end

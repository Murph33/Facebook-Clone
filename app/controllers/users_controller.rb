class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def home
    # @user = User.find_by_id(session[:user_id])
    @user ||= current_user
    @user ||= User.new
    @status = Status.new
    @statuses = Status.all_statuses @user
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name,
                    :email, :password, :password_confirmation, :gender, :birth_date)
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome to Facebook"
    else
      render :new, alert: "Something went wrong!"
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    user_params = params.require(:user).permit(:first_name, :last_name,
                    :email, :password, :password_confirmation, :gender, :birth_date)
    @user = User.find session[:user_id]
    if @user.authenticate(params[:user][:current_password]) && @user.update(user_params)
      redirect_to @user, notice: "Profile updated!"
    else
      render :edit, alert: "Something went wrong!"
    end
  end

  def show
    @user = User.find params[:id]
    @status = Status.new
    @friends = (@user.friends + @user.inverse_friends).shuffle
  end

  def destroy

  end
end

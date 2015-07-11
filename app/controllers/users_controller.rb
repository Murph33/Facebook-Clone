class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:home, :new, :create]

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

    @user = User.new user_params
    @user.profile = Profile.new
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome to Fakebook"
    else
      render :new, alert: "Something went wrong!"
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find session[:user_id]
    if @user.authenticate(params[:user][:current_password]) && @user.update(user_params)
      redirect_to @user, notice: "Profile updated!"
    else
      render :edit, alert: "Something went wrong!"
    end
  end

  def show
    @user = User.find params[:id]
    @statuses = @user.statuses
    @status = Status.new
    @post = Post.new
    @comment = Comment.new
    @friends = (@user.all_friends).shuffle
    @photos = @user.photos.order("created_at desc")
    #SHOULD ADD SOMETHING THAT IS LIKE user.all_photos AND INCLUDED TAGGED PHOTOS.
    #..... once I implement tagging LOL!
  end

  def destroy

  end

  def friends

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                  :password_confirmation, :gender, :birth_date, :picture)
  end
end

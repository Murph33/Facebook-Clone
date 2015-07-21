class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:home, :new, :create, :activate]
  before_action :verify_account!, except: [:home, :activate, :create]

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
      UserMailer.notify_new_user(@user).deliver_now
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome to Fakebook"
    else
      render :new, alert: "Something went wrong!"
    end
  end

  def edit
    @user = current_user
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
    @message = Message.new
    @user = User.find params[:id]
    @message_variable = [current_user.id, @user.id].sort.join("_")
    @statuses = @user.statuses
    @status = Status.new
    @post = Post.new
    @comment = Comment.new
    @friends = (@user.all_friends).shuffle
    @photos = @user.all_photos
    @request = Request.new
    #SHOULD ADD SOMETHING THAT IS LIKE user.all_photos AND INCLUDED TAGGED PHOTOS.
    #..... once I implement tagging LOL!
  end

  def destroy

  end

  def friends
    @user = User.find params[:id]
    @friends = @user.all_friends
  end

  def search
    @users = User.fuzzy_search({first_name: params[:search],
                                last_name: params[:search]}, false)
    render
  end

  def activate
    user = User.find_by_token params[:token]
    user.update(active:true)
    redirect_to root_path, notice: "Thanks for activating your account.  Enjoy your experience"
  end

  def tagging_friends_search
    friends = current_user.friends.fuzzy_search({first_name: params[:search],
                                            last_name: params[:search]}, false)
    inverse_friends = current_user.inverse_friends.fuzzy_search({first_name: params[:search],
                                            last_name: params[:search]}, false)
    photo = Photo.find params[:photo_id]
    if current_user.first_name.downcase[0..2] == params[:search].downcase[0..2] ||
         current_user.last_name.downcase[0..2] == params[:search].downcase[0..2]
      friends += [current_user]
    end
    @all_friends = friends + inverse_friends - photo.tagged_users
  end
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                  :password_confirmation, :gender, :birth_date, :picture)
  end
end

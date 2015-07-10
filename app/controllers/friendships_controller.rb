class FriendshipsController < ApplicationController

  def create
    friend = User.find_by_id params[:user_id]
    @friendship = current_user.friendships.new
    @friendship.friend = friend
    if @friendship.save
      Request.find_request(friend, current_user).destroy_all
      redirect_to root_path, notice: "New friend made"
    else
      redirect_to users_path, alert: "Something went wrong"
    end
  end

  def destroy
    friend = User.find_by_id(params[:id])
    friendship = Friendship.find_friendship(current_user,friend)
    friendship.destroy_all
    redirect_to current_user
  end

end

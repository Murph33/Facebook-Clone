class FriendshipsController < ApplicationController
  before_action :verify_account!
  before_action :authenticate_user!
  def create
    friend = User.friendly.find_by_id params[:user_id]
    @friendship = current_user.friendships.new
    @friendship.friend = friend
    if @friendship.save
      @request = Request.find_request(friend, current_user).first
      @request.destroy
      render
    else
      render {create_failure}
    end
  end

  def destroy
    friend = User.friendly.find_by_id(params[:id])
    friendship = Friendship.find_friendship(current_user,friend)
    friendship.destroy_all
    redirect_to current_user
  end

end

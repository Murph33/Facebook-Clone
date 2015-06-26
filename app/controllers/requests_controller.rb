class RequestsController < ApplicationController

  def create
    request = current_user.active_requests.new
    request.requestee = User.find(params[:user_id])
    if request.save
      redirect_to users_path, notice: "Friend request sent"
    else
      redirect_to users_path, alert: "Friend request didn't go through"
    end
  end

  def destroy
    requester = User.find(params[:id])
    Request.where('requestee_id = ? AND requester_id = ?',
                    current_user, requester).destroy_all
    redirect_to current_user
  end

end

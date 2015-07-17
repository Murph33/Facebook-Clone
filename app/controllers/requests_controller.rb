class RequestsController < ApplicationController
  before_action :verify_account!
  before_action :authenticate_user!
  def create
    request = current_user.active_requests.new
    request.requestee = User.find(params[:user_id])
    if request.save
      render
    else
      render {create_failure}
    end
  end

  def destroy
    requester = User.find(params[:id])

    @request = Request.where('requestee_id = ? AND requester_id = ?',
                    current_user, requester).first
    Request.where('requestee_id = ? AND requester_id = ?',
                    current_user, requester).destroy_all
    render
  end

end

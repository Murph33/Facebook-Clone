class StatusesController < ApplicationController
  before_action :verify_account!
  before_action :authenticate_user!
  
  def create
    status_params = params.require(:status).permit(:body)
    @status = Status.new status_params
    user = User.find current_user.id
    @status.user = user
    respond_to do |format|
      if @status.save
        format.js { render }
        format.html { redirect_to root_path, notice: "Status posted" }
      else
        format.js { render "create_failure" }
        format.html { render "/users/home", alert: "Something broke" }
      end
    end
  end

  def edit
    @status = current_user.statuses.find params[:id]

  end

  def update
    @status = current_user.statuses.find params[:id]
    status_params = params.require(:status).permit(:body)
    if @status.update status_params
      render
    else
      render {update_failure}
    end
  end

  def destroy
    @status = current_user.statuses.find params[:id]
    @status.destroy
  end

end

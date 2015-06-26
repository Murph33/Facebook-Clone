class StatusesController < ApplicationController

  def create
    status_params = params.require(:status).permit(:body)
    @status = Status.new status_params
    user = User.find current_user
    @status.user = user
    if @status.save
      redirect_to root_path, notice: "Status posted"
    else
      render "/users/home", alert: "Something broke"
    end
  end

end

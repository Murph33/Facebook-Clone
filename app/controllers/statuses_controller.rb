class StatusesController < ApplicationController

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

end

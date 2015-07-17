class TaggingsController < ApplicationController

  def create
    tagging_params = params.require(:tagging).permit(:user_id, :photo_id)
    @tag = Tagging.create tagging_params
  end

  def destroy
    tagging = Tagging.where(photo_id: params[:photo_id], user_id: params[:user_id])
    @tag = tagging.first
    @tag ||= Tagging.find params[:id]
    tagging.destroy_all
    @tag.destroy
  end

end

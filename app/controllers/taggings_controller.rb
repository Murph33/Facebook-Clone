class TaggingsController < ApplicationController

  def create
    tagging_params = params.require(:tagging).permit(:user_id, :photo_id)
    @tag = Tagging.create tagging_params
    photo = Photo.find(params[:tagging][:photo_id])
    photo.touch
  end

  def destroy
    user = User.friendly.find_by_id params[:user_id]
    if user
      tagging = Tagging.where(photo_id: params[:photo_id], user_id: user.id)
      @tag = tagging.first
      tagging.destroy_all
    end
    @tag ||= Tagging.find params[:id]
    @tag.destroy
  end

end

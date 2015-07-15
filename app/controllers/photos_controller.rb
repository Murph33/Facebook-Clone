class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find_by_id(params[:user_id])
    @photos = Photo.where(user:user)
  end

  def new
    @photo = Photo.new
  end

  def create
    photo_params = params.require(:photo).permit(:description, :image, :album_id)
    @photo = current_user.photos.new photo_params
    @photo.album ||= Album.create user_id:current_user.id, title: "Untitled Album"
    if @photo.album.title == "Profile Pictures"
      current_user.update(picture: photo_params[:image])
      current_user.save
    end
    if @photo.save
      render
    else
      render {create_failure}
    end
  end

  def destroy

  end



end

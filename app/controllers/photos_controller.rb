class PhotosController < ApplicationController
  before_action :verify_account!
  before_action :authenticate_user!

  def index
    user = User.find_by_id(params[:user_id])
    @photos = Photo.where(user:user)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new photo_params
    @photo.album ||= Album.create user_id:current_user.id, title: "Untitled Album"
    @photo.album.touch
    if @photo.album.title == "Profile Pictures"
      current_user.update(picture: photo_params[:image])
      current_user.save
    end
    if @photo.save
      redirect_to user_album_path(current_user, @photo.album)
    else
      render :new
    end
  end

  def edit
    @photo = current_user.photos.find(params[:id])
  end

  def update
    @photo = current_user.photos.find(params[:id])
    if @photo.update(photo_params)
      redirect_to user_photos_of_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    album = @photo.album
    respond_to do |format|
      if @photo.destroy
        format.js {render}
        format.html { redirect_to user_photos_of_path(current_user)}
      else
        format.js {render destroy_failure}
      end
    end
  end

  def photos_of
    @user           = User.find(params[:user_id])
    @photos_of_user = @user.tagged_photos.order("created_at desc")
    @album = Album.new
    1.times { @album.photos.build }
    @albums         = @user.albums.select {|a| a.photos.length > 0}.sort_by {|p| p.updated_at}.reverse
    @request = Request.new
  end

  def photo_params
    params.require(:photo).permit(:description, :image, :album_id)
  end
end

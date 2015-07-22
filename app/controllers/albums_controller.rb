class AlbumsController < ApplicationController
  before_action :verify_account!
  before_action :authenticate_user!

  def new
    @album = Album.new
    1.times { @album.photos.build }
  end

  def create
    @album = current_user.albums.new album_params
    if @album.save
      redirect_to user_album_path(current_user, @album)
    else
      photo_count = 1 - @album.photos.length
      photo_count.times { @album.photos.build }
      @user           = User.friendly.find(params[:user_id])
      render :new
    end
  end

  def edit
    @album = current_user.albums.find(params[:id])
  end

  def update
    @album = current_user.albums.find(params[:id])
    respond_to do |format|
      if @album.update album_params
        format.js {redirect_to user_album_path(current_user,@album)}
      else
        format.js {render :edit}
      end
    end
  end

  def show
    @user = User.friendly.find params[:user_id]
    @album = @user.albums.find params[:id]
    if @album.user == current_user || (@album.user.all_friends.include?(current_user))
    else
      redirect_to current_user, notice: "You don't have permission to view that album"
    end
  end

  def destroy
    @album = current_user.albums.find params[:id]
    @album.destroy
  end

  def album_params
    params.require(:album).permit(:title, :description,
                  {photos_attributes: [:description, :image, :user_id, :_destroy]})
  end
end

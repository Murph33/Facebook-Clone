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
      render
    else
      photo_count = 1 - @album.photos.length
      photo_count.times { @album.photos.build }
      render { create_failure }
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

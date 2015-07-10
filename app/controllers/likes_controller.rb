class LikesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_likeable

  def create
    @like = current_user.likes.new
    @like.likeable = @likeable
    if @like.save
      render
    else
      render { create_failure }
    end
  end

  def destroy
    @like = current_user.likes.find params[:id]
    @likeable = @like.likeable

    @like.destroy
    render
  end

  private

  def find_likeable
    if params[:post_id]
      @likeable = Post.find params[:post_id]
      # @post     = @likeable
    elsif params[:photo_id]
      @likeable = Photo.find params[:photo_id]
      # @photo    = @likeable
    elsif params[:status_id]
      @likeable = Status.find params[:status_id]
      # @status   = @likeable
    elsif params[:comment_id]
      @likeable = Comment.find params[:comment_id]
      # @reply    = @likeable
    end
  end


end

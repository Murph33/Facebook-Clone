class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: [:create]
  before_action :verify_account!
  def create
    @comment = current_user.comments.new comment_params
    @comment.commentable = @commentable
    if @comment.save
      render
    else
      render { create_failure }
    end
  end

  def edit
    @comment = current_user.comments.find params[:id]
    @commentable = @comment.commentable
  end

  def update
    @comment = current_user.comments.find params[:id]
    if @comment.update comment_params
      render
    else
      render {create_failure}
    end
  end

  def destroy
    @comment = current_user.comments.find params[:id]
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    if params[:post_id]
      @commentable = Post.find params[:post_id]
    elsif params[:photo_id]
      @commentable = Photo.find params[:photo_id]
    elsif params[:status_id]
      @commentable = Status.find params[:status_id]
    end
  end

end

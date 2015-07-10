class PostsController < ApplicationController

  def create
    post_params = params.require(:post).permit(:body)
    @post = current_user.sent_posts.new post_params
    @user = User.find params[:user_id]
    @post.postee = @user
    @like = @post.likes.find_by_user_id current_user.id
    respond_to do |format|
      if @post.save
        format.js { render }
        format.html { redirect_to @user, notice: "Message Posted!" }
      else
        flash[:alert] = "Something went wrong!"
        format.js { render }
        format.html { render "/users/show" }
      end
    end
  end

end

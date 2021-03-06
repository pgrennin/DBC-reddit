class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create

    @comment = Comment.new(comment_params)

    @comment.post = Post.find(params[:post_id])
    if comment_params[:comment_id] != ""
      @comment.comment_id = comment_params[:comment_id]
      @comment.post = nil
    end
    @comment.author = User.find(session[:user_id])
    parent_comment =  @comment.post == nil ? get_parent_comment(@comment) : @comment

    if @comment.save
      redirect_to subreddit_post_path(parent_comment.post.subreddit, parent_comment.post)
      # redirect_to(:back)
    else
      # render 'comments/new'
      #@errer = "I'm just not going to leave that comment"
      redirect_to(:back)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    @comment.destroy
    redirect_to subreddit_post_path(post.subreddit_id, post.id)
  end

  def update
    @comment = Comment.find(params[:id])
    render 'edit'
  end

  private
    def comment_params
      params.require(:comment).permit(:author, :body, :post, :comment_id)
    end
end




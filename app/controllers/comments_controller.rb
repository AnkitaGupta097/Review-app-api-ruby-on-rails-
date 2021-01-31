class CommentsController < ApplicationController
  def index
    post = Post.find(params[:post_id])
    render json: post.comments
  end

  def create
    post = Post.find(params[:post_id])
    new_comment = Comment.new(comments_params)
    post.comments << new_comment
    if post.save
      render json: new_comment
    else
      render json: { errors: post.errors }, status: 400
    end
  end

  def show
    comment = Comment.find_by(id: params[:id])
    if comment
      render json: comment
    else
      render json: { error: "Comment with id #{params[:id]} does not exist" }, status: 404
    end
  end

  def update
    comment = Comment.find_by(id: params[:id])
    if comment
      if comment.update(comments_params)
        render json: comment
      else
        render json: { errors: comment.errors }, status: 400
      end
    else
      render json: { error: "Comment with id #{params[:id]} does not exist" }, status: 404
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      render json: comment
    else
      render json: { error: comment.errors }, status: 400
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:likes, :dislikes, :reply)
  end
end

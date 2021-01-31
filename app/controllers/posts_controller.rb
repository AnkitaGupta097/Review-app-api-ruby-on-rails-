class PostsController < ApplicationController
  def index
    render json: Post.all, include: %i[comments user reviewable]
  end

  def show
    post = Post.find_by(id: params[:id])
    if post
      render json: post, include: %i[comments user reviewable]
    else
      render json: { error: "Post with id #{params[:id]} does not exist" }, status: 404
    end
  end

  def movie_user_nested_index
    user = User.find(params[:id])
    # check whether movie with given id exists
    Movie.find(params[:movie_id])
    posts = user.posts.where(reviewable_id: params[:movie_id], reviewable_type: 'Movie')
    render json: posts, include: %i[comments user reviewable]
  end

  def book_user_nested_index
    user = User.find(params[:id])
    # check whether book with given id exists
    Book.find(params[:book_id])
    posts = user.posts.where(reviewable_id: params[:book_id], reviewable_type: 'Book')
    render json: posts, include: %i[comments user reviewable]
  end

  def user_posts_index
    user = User.find(params[:id])
    render json: user.posts, include: %i[comments user reviewable]
  end

  def create
    user = User.find(params[:user_id])
    if params[:movie_id].present?
      movie = Movie.find(params[:movie_id])
      @post = Post.new({ reviewable: movie, user: user })
    elsif params[:book_id].present?
      book = Book.find(params[:book_id])
      @post = Post.new({ reviewable: book, user: user })
    end

    if @post.save
      render json: @post, include: %i[comments user reviewable]
    else
      render json: { errors: @post.errors }, status: 400
    end
  end

  def update
    post = Post.find_by(id: params[:id])
    if post
      if post.update(posts_params)
        render json: post
      else
        render json: { errors: post.errors }, status: 400
      end
    else
      render json: { error: "Post with id #{params[:id]} does not exist" }, status: 404
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      render json: post
    else
      render json: { errors: post.errors }, status: 400
    end
  end

  private

  def posts_params
    params.require(:post).permit(:content, :reviewable_id, :reviewable_type)
  end
end

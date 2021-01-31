class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies, include: [:posts]
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie, include: [:posts]
    else
      render json: { error: "Movie with id #{params[:id]} does not exist" }, status: 404
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: movie
    else
      render json: { errors: movie.errors }, status: 400
    end
  end

  def destroy
    movie = Movie.find(params[:id])
    if movie.destroy
      render json: movie
    else
      render json: { error: movie.errors }, status: 400
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director, :rating)
  end
end

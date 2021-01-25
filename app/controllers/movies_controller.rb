class MoviesController < ApplicationController

       def index
        movies= Movie.all
        render json:movies,include:[:users,:posts]
       end

       def show
        movie=  Movie.find_by(id:params[:id])
        if movie
        render json:movie,include:[:users,:posts]
        else
          render json:{error:"Movie with id #{params[:id]} does not exist"},status:404
        end
      end

      def create
       movie=Movie.new(movie_params)
        if movie.save
            render json:movie
         else
            render json:{errors:movie.errors},status:400
         end

    end

    def destroy
        movie=  Movie.find_by(id:params[:id])
      if movie
         destroyed_movie=movie.destroy
          render json:destroyed_movie
      else
        render json:{error:"Movie with id #{params[:id]} does not exist"},status:404
       end
    end 

    def movie_params
        params.require(:movie)  
        params.permit(:title,:director,:rating)
     end

end

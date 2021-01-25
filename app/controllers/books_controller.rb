class BooksController < ApplicationController

    def index
        users= Book.all
        render json:users,include:[:users,:posts]
       end

       def show
        book=  Book.find_by(id:params[:id])
        if book
        render json:book,include:[:users,:posts]
        else
          render json:{error:"Book with id #{params[:id]} does not exist"},status:404
        end
      end

      def create
        book=Book.new(book_params)
        if book.save
            render json:book
         else
            render json:{errors:book.errors},status:400
         end

    end

    def destroy
        book=  Book.find_by(id:params[:id])
      if book
         destroyed_book=book.destroy
          render json:destroyed_book
      else
        render json:{error:"Book with id #{params[:id]} does not exist"},status:404
       end
    end 


    def book_params
        params.require(:book)  
        params.permit(:title,:author,:rating)
     end
end

class BooksController < ApplicationController
  def index
    books = Book.all
    render json: books, include: [:posts]
  end

  def show
    book = Book.find_by(id: params[:id])
    if book
      render json: book, include: [:posts]
    else
      render json: { error: "Book with id #{params[:id]} does not exist" }, status: 404
    end
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: book
    else
      render json: { errors: book.errors }, status: 400
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      render json: book
    else
      render json: { error: "Book with id #{params[:id]} does not exist" }, status: 404
    end
  end

  private

  def book_params
    params.require(:book)
    params.permit(:title, :author, :rating)
  end
end

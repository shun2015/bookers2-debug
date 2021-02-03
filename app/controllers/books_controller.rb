class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_book,only: [:edit]

  def show
    @book = Book.find(params[:id])
    @user = User.find(current_user.id)
    @book_new = Book.new
    @Book_comment = BookComment.new
  end

  def index
    @book_all = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @book_all = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path
    else
      render "edit"
    end
  end

def correct_book
        @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end

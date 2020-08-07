class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book =Book.new
  end

  def create
    @book = Book.new(book_params)
    # User must exist 本を投稿する際には誰が投稿したのかという情報を追記する必要があります。
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user = current_user
      render "edit"
    else
    redirect_to books_path
    end
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
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def baria_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

end


# unless params[:id].to_i == current_user.id
      # redirect_to user_path(current_user)
    # end
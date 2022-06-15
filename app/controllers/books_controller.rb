class BooksController < ApplicationController
  
  def index
    # @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def show
    @bookn = Book.new
    @book = Book.find(params[:id])
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      # render :index
      redirect_to books_path
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id == current_user.id
      render "edit"
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
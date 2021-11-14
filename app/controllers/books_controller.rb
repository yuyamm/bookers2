class BooksController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def create
    @user = User.find(current_user.id)
    @books = Book.all
    @book = current_user.books.new(book_params)
    if @book.save
      flash[:notice] = "You have created successfully."
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user.id)
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end

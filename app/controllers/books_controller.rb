class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
    @user = User.find(current_user.id)
    @newbook = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @newbook = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = 'You have creatad book successfully.'
      redirect_to book_path(@book.id)
    else
      session[:error] = @book.errors.full_messages
      session[:error_count] = @book.errors.count
      redirect_to books_path
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      flash[:danger] = 'You dont have permission'
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      flash[:danger] = 'You dont have permission'
      redirect_to user_id(current_user.id)
    end
    if @book.update(book_params)
      flash[:success] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.user_id != current_user.id
      redirect_to user_id(current_user.id)
    end
    unless book.destroy
      flash[:danger] = 'Something error happened'
    end
    redirect_to user_path(current_user.id)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end

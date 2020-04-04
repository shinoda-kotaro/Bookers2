class UsersController < ApplicationController
  before_action :authenticate_user! , only: [:edit, :update, :show, :index]

  def about
  end

  def show
    @user = User.find(params[:id])
    @newbook = Book.new
    @books = @user.books
  end

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @newbook = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:danger] = 'You dont have permission'
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:danger] = 'You dont have permission'
      redirect_to user_path(current_user.id)
    end
    if @user.update(user_params)
      flash[:success] = 'You have updated user successfully.'
      redirect_to user_path(current_user.id)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end

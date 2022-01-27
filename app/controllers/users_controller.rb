class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update,:edit,:destroy]
  before_action :authenticate_user!, only: [:show]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end
  def edit
    @user = User.find(params[:id])
    @books = @user.books
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end


  def update
    @books = @user.books
    if @user.update(user_params)
      redirect_to user_path, notice: "You have updated user successfully."
    else
      render "edit"
    end

    def followings
      user = User.find(params[:id])
      @users = user.followings
    end

    def followers
      user = User.find(params[:id])
      @users = user.followers
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user),notice: 'ゲストユーザーはプロフィール編集できません。'
    end
  end
end

class BooksController < ApplicationController
before_action :current_user, only: [:edit, :update]
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.find(params[:id])
    @book_new = Book.new
    @book_comment = BookComment.new
    impressionist(@book,nil,unique: [:ip_address])
  end

  def index
    @books = Book.includes(:favorited_users).sort{|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @book_new = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
     @user = User.find(current_user.id)
   unless  @book.user == current_user
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
    params.require(:book).permit(:title,:body)
  end
end

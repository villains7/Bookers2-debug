class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    
  end

  def destroy
  end
end

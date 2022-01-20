class BookCommentsController < ApplicationController
  def create
  end

private

def book_comment_params
  params.require(:book_comment).permit(:comment)
end

end

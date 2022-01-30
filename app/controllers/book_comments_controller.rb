class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      flash[:natice] = 'コメントを投稿しました'
      @comment.create_notification_comment(current_user,@comment.id)
      redirect_to request.referer
    else
     flash[:alert] = 'コメント投稿に失敗しました'
     redirect_to request.referer
    end
  end

 def destroy
   BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to request.referer
 end
private

def book_comment_params
  params.require(:book_comment).permit(:comment)
end

end

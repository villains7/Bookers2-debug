module NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    @visitor_comment = notification.comment_id
    case notification.action
    when 'follow'
      tag.a(notification.visitor.name, href: user_path(@visitor))
    when 'favorite'
      tag.a(notification.visitor.name, href: user_path(@visitor))
    when 'book_comment' then
      @comment = BookComment.find_by(id: @visitor_book_comment)
      @comment_book = @comment.body
      @microbook_title = @comment.book.title
      tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + taga("#{@book_title}",href: book_path(notification.book_id)) + 'にコメントしました'
    end
  end
end

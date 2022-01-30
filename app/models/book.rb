class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :notifications, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  is_impressionable counter_cache: true


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

   def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
   end

   def create_notification_favorite(current_user)
    notificaion = current_user.active_notifications.new(book_comment_id: nil, book_id: id, visited_id: user_id, action: 'favorite')
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
   end

  def create_notification_comment(current_user,book_comment_id)
    temp_ids = BookComment.where(book_id: id).select(:user_id).where.not("user_id = ? or user_id = ? ",current_user.id, user_id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user,book_comment_id,temp_id['user_id'])
    end
    save_notification_comment(current_user,book_comment_id, user_id)
  end

  def save_notification_comment(current_user,book_comment_id,visited_id)#通知をした人。通知されたコメント、通知された人
  notification = current_user.active_notifications.new(book_id: id,book_comment_id: book_comment_id, visited_id: visites_id,action: 'book_comment')
   if notification.visitor_id == notification.visited_id
    notificaion.checked  = true
   end
   notification.save if notification.valid?
  end
end

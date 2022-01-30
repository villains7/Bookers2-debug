class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :followed_id,dependent: :destroy
  has_many :relationships, class_name: "Relationship",foreign_key: :follower_id,dependent: :destroy
  has_many :followers, through: :reverse_of_relationships,source: :follower
  has_many :followings, through: :relationships, source: :followed

  # 中間テーブルを介してデータを取れる
  has_many :followers, through: :reverse_of_relationships, source: :following
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :active_notifications, class_name: "Notification",foreign_key: "visitor_id",dependent: :destroy
  has_many :passive_notifications, class_name: "Notification",foreign_key: "visited_id",dependent: :destroy
  has_one_attached :profile_image


  def self.guest
    find_or_create_by!(name: 'guestuser',email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'guestuser'
    end
  end

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def create_notification_follow(current_user)
    notification = current_user.active_notifications.new(
      visited_id: id,
      action: 'follow'
      )
      notification.save if notification.valid?
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end




  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end


end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships,source: :follower
  #through使うと中間テーブルを介した先のデータを取ってくることができる
  has_many :reverse_of_rerationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :reverse_of_rerationships, source: :following
  has_one_attached :profile_image

  def is_followed_by?(user)
    reverse_of_rerationships.find_by(following_id: user.id).present?
  end


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end


end

class Notification < ApplicationRecord
  default_scope -> {order(created_at: :desc)}#新着順表示
  belongs_to :visitor, class_name: "User",optional: true#外部キーの空を許可
  belongs_to :visited, class_name: "User",optional: true
  belongs_to :book, optional: true
  belongs_to :book_comment, optional: true
end

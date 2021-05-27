class Comment < ApplicationRecord
  belongs_to :user  #Comment.userでコメントの所有者を取得
  belongs_to :board  #Comment.boardでそのコメントがされた投稿を取得

  validates :comment, presence: true, length: { maximum: 140 }
end

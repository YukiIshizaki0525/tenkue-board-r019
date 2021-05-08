class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  has_many :boards

  has_many :likes, dependent: :destroy
  has_many :likes_boards, through: :likes, source: :board

  def already_favorited?(board)
    self.likes.exists?(board_id: board.id)
  end
end

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :confirmable, :lockable, :timeoutable, :trackable

  has_many :boards

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :likes_boards, through: :likes, source: :board

  def already_likes?(board)
    self.likes.exists?(board_id: board.id)
  end
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
        presence: true,
        format: { with: VALID_EMAIL_REGEX,
                  message: "は半角英数字で登録してください" },
        uniqueness: { case_sensitive: false }


  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{8,32}\z/
  validates :password_confirmation,
        presence: true,
        format: { with: VALID_PASSWORD_REGEX,
                  message: "は8~32文字で半角英字と半角数字のいずれとも含む必要があります" }

  validates :password,
        presence: true,
        format: { with: VALID_PASSWORD_REGEX,
                  message: "は8~32文字で半角英字と半角数字のいずれとも含む必要があります" }
  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'ゲストユーザー') do |user|
      o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
      user.password = (0..19).map { o[rand(o.length)] }.join
      user.password_confirmation = user.password
    end
  end
end

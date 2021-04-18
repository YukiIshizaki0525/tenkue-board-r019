class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end
  
  VALID_NAME_REGEX = /\A[0-9]+\z/
  validates :name,
            presence: true,
            format: { with: VALID_NAME_REGEX }


  has_many :boards
end

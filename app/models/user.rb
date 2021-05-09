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
          
end



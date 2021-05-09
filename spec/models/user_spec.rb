require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    let(:user){ build(:user) }
    context '正しく登録できる' do 
      it '条件満たしているので登録可能' do
        user = build(:user)
        expect(user).to be_valid
      end
      
    end
    
    context '正しく登録でき無い' do 
      
      it 'メールアドレスに全角文字が含まれるため登録不可' do
        user = build(:user, email: "ｃｈｏｃｏｌａｔｅ111@www.com")
        user.valid?
        expect(user.errors[:email]).to include("は半角英数字で登録してください")
      end

      it 'passwordが７文字以下であれば登録不可' do
        user = build(:user, password: "Aa1q", password_confirmation: "Aa1q")
        user.valid?
        expect(user.errors[:password]).to include("は8~32文字で半角英字と半角数字のいずれとも含む必要があります")
      end

      it 'パスワードに半角英字が含まれていないため登録不可' do
        user = build(:user, password: "123456789", password_confirmation: "123456789")
        user.valid?
        expect(user.errors[:password]).to include("は8~32文字で半角英字と半角数字のいずれとも含む必要があります")
      end
    end
  end      
end
      
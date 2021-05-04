
require 'rails_helper'
RSpec.describe Board, type: :model do
  let(:user) { create(:user) }
  let(:board) { build(:board, user_id: user.id) }
  describe "掲示板投稿機能" do
    context '正常系' do
      it '正しく投稿できること' do
        expect(board).to be_valid
      end
    end
    context '異常系' do
      it '投稿の内容は必須であること' do
        board = build(:board, content: nil)
        board.valid?
        expect(board.errors[:content]).to include("を入力してください")
      end
      it '投稿の内容は140文字以内であること' do
        board = build(:board, content: "a" * 141)
        board.valid?
        expect(board.errors[:content]).to include("は140文字以内で入力してください")
      end
    end
  end
end
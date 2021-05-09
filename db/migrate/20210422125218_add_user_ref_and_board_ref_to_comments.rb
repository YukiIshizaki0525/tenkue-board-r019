class AddUserRefAndBoardRefToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :user, foreign_key: true, null: false
    add_reference :comments, :board, foreign_key: true, null: false
  end
end

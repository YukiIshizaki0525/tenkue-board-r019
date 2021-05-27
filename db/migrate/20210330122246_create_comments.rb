class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string      :name
      t.text        :comment
      t.text        :board
      t.references :user, foreign_key: true, null: false
      t.references :board, foreign_key: true, null: false
      t.timestamps
    end
  end
end

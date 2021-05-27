class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.siring      :name
      t.text        :comment
      t.text        :board
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

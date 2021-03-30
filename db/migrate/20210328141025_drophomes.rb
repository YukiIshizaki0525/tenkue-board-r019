class Drophomes < ActiveRecord::Migration[5.2]
  def change
    drop_table :homes
  end
end

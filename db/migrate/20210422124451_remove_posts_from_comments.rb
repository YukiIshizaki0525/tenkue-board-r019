class RemovePostsFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :posts
  end
end

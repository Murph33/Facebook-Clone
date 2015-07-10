class DropUserIdAddPosterIdToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :user_id
    add_column :posts, :poster_id, :integer
  end
end

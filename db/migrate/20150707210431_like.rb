class Like < ActiveRecord::Migration
  def change

    remove_column :likes, :post_id

    remove_column :likes, :photo_id
    # remove_column :likes, :reply_id

  end
end

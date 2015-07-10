class AddRepliesToLikes < ActiveRecord::Migration
  def change
    add_reference :likes, :reply, index: true, foreign_key: true
  end
end

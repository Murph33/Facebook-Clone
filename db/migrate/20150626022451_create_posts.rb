class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :postee_id

      t.timestamps null: false
    end
    add_index :posts, :postee_id
  end
end

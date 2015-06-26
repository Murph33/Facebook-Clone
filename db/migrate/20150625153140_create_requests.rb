class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :requester_id
      t.integer :requestee_id
      t.timestamps null: false
    end
    add_index :requests, :requestee_id
    add_index :requests, :requester_id
  end
end

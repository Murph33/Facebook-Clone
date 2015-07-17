class AddTokenAndActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :active, :boolean
  end
end

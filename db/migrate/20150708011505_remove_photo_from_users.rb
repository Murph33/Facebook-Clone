class RemovePhotoFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :photo, :string
  end
end

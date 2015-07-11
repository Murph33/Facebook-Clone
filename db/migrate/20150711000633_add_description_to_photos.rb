class AddDescriptionToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :description, :text
    add_column :photos, :image, :string
    remove_column :photos, :name
    end
end

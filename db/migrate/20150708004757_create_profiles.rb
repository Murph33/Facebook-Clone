class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :cover_photo
      t.string :birth_place
      t.string :residence
      t.string :phone

      t.timestamps null: false
    end
  end
end

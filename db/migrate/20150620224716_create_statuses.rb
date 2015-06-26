class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :body

      t.timestamps null: false
    end
  end
end

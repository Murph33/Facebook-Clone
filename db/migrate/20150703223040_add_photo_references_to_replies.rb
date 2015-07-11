class AddPhotoReferencesToReplies < ActiveRecord::Migration
  def change
    # add_reference :replies, :photo, index: true, foreign_key: true
  end
end

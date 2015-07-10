class AddReplyableToReplies < ActiveRecord::Migration
  def change
    add_reference :replies, :replyable, polymorphic: true, index: true
  end
end

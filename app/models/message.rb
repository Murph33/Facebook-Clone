class Message < ActiveRecord::Base

  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  validate :not_self

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  def self.find_conversation user_id1, user_id2
    where("(sender_id = :user_id  AND receiver_id = :friend_id) OR
                (sender_id = :friend_id  AND receiver_id = :user_id)",
                {user_id: user_id1, friend_id: user_id2})
  end

  private

  def not_self
    if sender_id == receiver_id
      errors.add(:sender_id, "Don't message yourself")
    end
  end

end

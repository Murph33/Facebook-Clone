class Friendship < ActiveRecord::Base

  belongs_to :friend, class_name:  "User"
  belongs_to :user
  validates :friend_id, uniqueness: {scope: :user_id}, presence: true
  validate :not_self
  validates :user_id, presence: true
  def not_self
    if user_id == friend_id
      errors.add(:user_id, "Can't friend yourself")
    end
  end

  def self.find_friendship user, friend
    where("(user_id = :user_id  AND friend_id = :friend_id) OR
              (user_id = :friend_id  AND friend_id = :user_id)",
              {user_id: user.id, friend_id: friend.id})
  end
end

class Friendship < ActiveRecord::Base

  belongs_to :friend, class_name:  "User"
  belongs_to :user
  validates :friend_id, uniqueness: {scope: :user_id}, presence: true
  validate :not_self
  validates :user_id, presence: true
  validate :no_duplicate

  def self.friendship_exists?(user_id, friend_id)
    where("(user_id = :user_id  AND friend_id = :friend_id) OR
              (user_id = :friend_id  AND friend_id = :user_id)",
              {user_id: user_id, friend_id: friend_id})
  end

  private

  def no_duplicate
    if (Friendship.find_friendship User.find(user_id), User.find(friend_id)).present?
      errors.add(:user_id, "Only one friendship between a pair")
    end
  end

  def not_self
    if user_id == friend_id
      errors.add(:user_id, "Can't friend yourself")
    end
  end

  def self.find_friendship user, friend
    # user_id = user.is_a? User ? user.id : user
    where("(user_id = :user_id  AND friend_id = :friend_id) OR
              (user_id = :friend_id  AND friend_id = :user_id)",
              {user_id: user.id, friend_id: friend.id})
  end

end

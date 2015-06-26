class Request < ActiveRecord::Base
  belongs_to :requester, class_name: "User"
  belongs_to :requestee, class_name: "User"
  validate :not_self
  validate :no_inverse
  validates :requester_id, presence: true
  validates :requestee_id, presence: true, uniqueness: {scope: :requester_id}

  def no_inverse
    if User.find(requester_id).requester_ids.include?(requestee_id)
      errors.add(:requester_id, "Don't duplicate requests")
    end
  end

  def not_self
    if requester_id == requestee_id
      errors.add(:requester_id, "Can't friend yourself")
    end
  end
  def self.find_request requester, requestee
    where("(requester_id = :requester_id  AND friend_id = :friend_id) OR
              (user_id = :friend_id  AND friend_id = :user_id)",
              {user_id: user.id, friend_id: friend.id})
  end
end

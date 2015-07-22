class Request < ActiveRecord::Base
  belongs_to :requester, class_name: "User"
  belongs_to :requestee, class_name: "User"
  validate :not_self
  validate :no_inverse
  validates :requester_id, presence: true
  validates :requestee_id, presence: true, uniqueness: {scope: :requester_id}
  validate :no_duplicate

  private

  def no_duplicate
    if Friendship.friendship_exists?(requester_id, requestee_id).any?
      errors.add(:requester_id, "Only one friendship between a pair")
    end
  end

  def self.find_request requester, requestee
    where("(requester_id = :requester_id  AND requestee_id = :requestee_id) OR
              (requester_id = :requestee_id  AND requestee_id = :requester_id)",
              {requestee_id: requester.id, requester_id: requestee.id})
  end

  def no_inverse
    if User.friendly.find(requester_id).requester_ids.include?(requestee_id)
      errors.add(:requester_id, "Don't duplicate requests")
    end
  end

  def not_self
    if requester_id == requestee_id
      errors.add(:requester_id, "Can't friend yourself")
    end
  end
end

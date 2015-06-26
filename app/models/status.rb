class Status < ActiveRecord::Base

  has_many :replies, dependent: :destroy
  belongs_to :user

  def self.all_statuses user
    where("user_id IN (?) OR user_id = ?", user.friend_ids, user.id)
  end
  # works below but that's really dumb
  # def self.all_statusesss user
  #   where("user_id IN (:array) OR user_id = :user_id", {array: user.friend_ids, user_id: user.id})
  # end
end

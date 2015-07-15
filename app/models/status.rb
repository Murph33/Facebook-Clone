class Status < ActiveRecord::Base

  # has_many :replies, dependent: :destroy, as: :replyable
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :likes, dependent: :destroy, as: :likeable
  has_many :liking_users, through: :likes, source: :user
  belongs_to :user

  def truncated
    body[0..250]
  end

  def display
    "#{user.full_name}: #{body} #{created_at}"
  end

  def like_for user
    likes.find_by_user_id user.id
  end

  def self.all_statuses user
    where("user_id IN (?) OR user_id = ?", user.friend_ids, user.id).order("created_at desc")
  end
  # works below but that's really dumb
  # def self.all_statusesss user
  #   where("user_id IN (:array) OR user_id = :user_id", {array: user.friend_ids, user_id: user.id})
  # end
end

class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likeable, polymorphic: true
  validates :user, presence: true
  validates :user_id, uniqueness: {scope: [:likeable_type, :likeable_id]}
  validates :likeable_id, presence: true
  validates :likeable_type, presence: true

  # belongs_to :reply
  # belongs_to :photo
  # belongs_to :post
  # belongs_to :status
  # validate :one_like
  # def one_like
  #   count = 0
  #   count += 1 if reply_id != nil
  #   count += 1 if photo_id != nil
  #   count += 1 if post_id != nil
  #   unless count == 1
  #     errors.add(:user_id, "One user likes one thing")
  #   end
  # end
end

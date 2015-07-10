class Photo < ActiveRecord::Base
  # has_many :replies, dependent: :destroy, as: :replyable
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :likes, dependent: :destroy, as: :likeable
  # has_many :likes, dependent: :destroy, as: :likeable
  has_many :liking_users, through: :likes, source: :user

  belongs_to :user
  belongs_to :album
end

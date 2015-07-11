class Photo < ActiveRecord::Base

  mount_uploader :image, PhotoUploader

  # has_many :replies, dependent: :destroy, as: :replyable
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :likes, dependent: :destroy, as: :likeable
  # has_many :likes, dependent: :destroy, as: :likeable
  has_many :liking_users, through: :likes, source: :user
  # has_many :albums, through: :pastings, source: :album
  # has_many :pastings, dependent: :destroy
  belongs_to :user
  belongs_to :album
end

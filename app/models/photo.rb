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

  has_many :tagged_users, through: :taggings, source: :user

  def truncated
    description[0..250]
  end

  def like_for user
    likes.find_by_user_id user.id
  end

end

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, dependent: :destroy, as: :likeable
  has_many :liking_users, through: :likes, source: :user
  has_many :replies, dependent: :destroy
  validates :body, presence: true
  validates :commentable_id, presence: true

  def truncated
    body[0..175]
  end

  def description
    body
  end

  def tagged_users
    nil
  end

  def comments
    Comment.all
  end

  def like_for user
    likes.find_by_user_id user.id
  end

end

class Post < ActiveRecord::Base

  has_many :likes, dependent: :destroy, as: :likeable
  has_many :liking_users, through: :likes, source: :user

  has_many :comments, dependent: :destroy, as: :commentable
  has_many :commenting_users, through: :comments, source: :user
  # has_many :replies, dependent: :destroy, as: :replyable
  # has_many :replying_users, through: :replies, source: :user

  validates :body, presence: true
  validate :friends

  belongs_to :poster, class_name: "User"
  belongs_to :postee, class_name: "User"


  def truncated
    body[0..250]
  end

  def like_for user
    likes.find_by_user_id user.id
  end

  def display
    "#{poster.full_name} -> #{postee.full_name}: #{body} #{created_at}"
  end

  def user
    poster
  end

  def commentable
  end

  def description
  end

  def tagged_users
    []
  end

private

  def friends
    unless postee.all_friends.include? poster
      errors.add(:poster_id, "Only post on your friends walls")
    end
  end

end

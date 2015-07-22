  class User < ActiveRecord::Base

  POSSIBLE_GENDERS = ["Male", "Female", "Other"]

#  has_many :active_requests, class_name: "Request", foreign_key: :requester_id,
##                        dependent: :destroy
##  has_many :passive_requests, class_name: "Request", foreign_key: :requestee_id,
##                        dependent: :destroy
##  has_many :requestees, through: :active_requests
##  has_many :requesters, through: :passive_requests
##
##  has_many :friendships, dependent: :destroy
##  has_many :friends, through: :friendships
##  has_many :inverse_friends, through: :inverse_friendships, source: :user
##  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id",
#              dependent: :destroy


  has_secure_token
  has_secure_password

  has_one :profile, dependent: :destroy
  mount_uploader :picture, ProfilePictureUploader

  has_many :sent_messages, class_name: :Message, foreign_key: :sender_id, dependent: :destroy
  has_many :received_messages, class_name: :Message, foreign_key: :receiver_id, dependent: :destroy
  has_many :receivers, through: :sent_messages
  has_many :senders, through: :received_messages

  has_many :requesters, through: :passive_requests
  has_many :requestees, through: :active_requests
  has_many :active_requests, class_name: :Request, foreign_key: :requester_id, dependent: :destroy
  has_many :passive_requests, class_name: :Request, foreign_key: :requestee_id, dependent: :destroy

  has_many :friends, through: :friendships
  has_many :friendships, dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :inverse_friendships, class_name: :Friendship, foreign_key: :friend_id, dependent: :destroy

  has_many :albums, dependent: :destroy

  has_many :tagged_photos, through: :taggings, source: :photo
  has_many :taggings, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :likeable, source_type: :Photo
  has_many :liked_statuses, through: :likes, source: :likeable, source_type: :Status
  has_many :liked_posts, through: :likes, source: :likeable, source_type: :Post
  has_many :liked_comment, through: :likes, source: :likeable, source_type: :Comment

  has_many :replied_to_comments, through: :replies, source: :comment

  has_many :commented_posts, through: :comments, source: :commentable,
                                                 source_type: :Post
  has_many :commented_photos, through: :comments, source: :commentable,
                                                 source_type: :Photo
  has_many :commented_statuses, through: :comments, source: :commentable,
                                                 source_type: :Status
  has_many :comments, dependent: :destroy



  has_many :sent_posts, class_name: :Post, foreign_key: :poster_id, dependent: :destroy
  has_many :postees, through: :sent_posts
  has_many :posters, through: :received_posts
  has_many :received_posts, class_name: :Post, foreign_key: :postee_id, dependent: :destroy
  # has_many :passive_relationships, class_name: "Relationships", foreign_key: "followed_id", dependent: :destroy
  # has_many :followers, through: :passive_relationships, source: :follower
  # has_many :following, through: :active_relationships, source: :followed
  #
  #
  #
  # has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # has_many :followers, through: :active_relationships,

  has_many :statuses, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :photos, dependent: :destroy

  # has_many :friends, through: :friendships
  # has_many :friendships, class_name: "Friendship", foreign_key: "friend_a_id",
  #                           dependent: :destroy
  # has_many :inverse_friends, through: :friendships
  # has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_b_id",
  #                           dependent: :destroy



  # has_many :friendships
  # has_many :friends, through: :friendships
  # has_many :inverse_friendships, class_name: :friendship, foreign_key: :friend_id
  # has_many :inverse_friends, through: :inverse_friendships, source: :user

  after_create :on_create
  after_initialize :inactive
  after_save :unique_token
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: :true, uniqueness: true,
            format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :birth_date, presence: true
  # validate :validate_gender
  validate :age

  def give_genders
    POSSIBLE_GENDERS
  end

  def all_friends
    (friends + inverse_friends)
  end

  def sorted_all_friends
    (friends + inverse_friends).sort_by { |f| f.first_name }
  end

  def mutual_friends user
    all_friends & user.all_friends
  end

  def newsfeed
    (received_posts + statuses + photos).sort_by {|x| x.updated_at}.reverse
  end

  def validate_gender
    unless POSSIBLE_GENDERS.include? gender
      errors.add(:gender, "Use a radio button")
    end
  end

  def full_name
    "#{first_name} #{last_name}".strip.squeeze(" ")
  end

  def tagged_photo photo
    taggings.find_by_photo_id(photo.id)
  end

  def all_photos
    (tagged_photos + photos).uniq.sort_by {|photo| photo.updated_at}
  end

  def unseen_messages
    received_messages.where(seen: false)
  end

  private

  def age
    unless birth_date > (Date.today - 115.years)
      errors.add(:birth_date, "you aren't that old")
    end
    if birth_date > (Date.today - 13.years)
      errors.add(:birth_date, "must be 13 or older")
    end
  end

  def on_create
    Profile.create user_id: id unless profile
    albums.create title: "Timeline Photos"
    albums.create title: "Profile Pictures"
  end

  def inactive
    self.active ||= false
  end

  def unique_token
    users = User.where("token = ?", token)
    regenerate_token unless users.length == 1
    unique_token unless users.length == 1
  end

  # def liked_posts
  #   post_ids = likes.where(likeable_type: "Post").pluck(:likeable_id)
  #   Post.find post_ids
  # end

end
  # def timeline
  #   timeline = []
  #   received_posts.each { |post| timeline << post }
  #   statuses.each { |status| timeline << status }
  #   timeline = timeline.sort_by {|x| x.created_at}
  # end

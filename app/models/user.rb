  class User < ActiveRecord::Base

  POSSIBLE_GENDERS = ["Male", "Female", "Trans", "Fluid"]

  has_many :active_requests, class_name: "Request", foreign_key: :requester_id,
                        dependent: :destroy
  has_many :passive_requests, class_name: "Request", foreign_key: :requestee_id,
                        dependent: :destroy
  has_many :requestees, through: :active_requests
  has_many :requesters, through: :passive_requests

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id",
              dependent: :destroy

  # has_many :passive_relationships, class_name: "Relationships", foreign_key: "followed_id", dependent: :destroy
  # has_many :followers, through: :passive_relationships, source: :follower
  # has_many :following, through: :active_relationships, source: :followed
  #
  #
  #
  # has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # has_many :followers, through: :active_relationships,
  has_secure_password
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

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: :true, uniqueness: true,
            format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :birth_date, presence: true
  validate :validate_gender
  validate :age

  def give_genders
    POSSIBLE_GENDERS
  end

  def age
    unless birth_date > (Date.today - 115.years)
      errors.add(:birth_date, "You aren't that old")
    end
  end
  def validate_gender
    unless POSSIBLE_GENDERS.include? gender
      errors.add(:gender, "Use a radio button")
    end
  end

  def full_name
    "#{first_name} #{last_name}".strip.squeeze(" ")
  end

end

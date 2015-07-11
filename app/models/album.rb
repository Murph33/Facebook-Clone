class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy
  # has_many :pastings, dependent: :destroy
  validates :title, uniqueness: {scope: :user_id}, presence: true
end

# MAKE A WARNING WHEN DELETING AN ALBUM DESTROYS PHOTOS

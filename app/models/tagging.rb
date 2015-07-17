class Tagging < ActiveRecord::Base
  validates :user_id, presence: true
  validates :photo_id, presence: true, uniqueness: {scope: :user_id}
  belongs_to :user
  belongs_to :photo
end

class Profile < ActiveRecord::Base
  belongs_to :user

  mount_uploader :cover_photo, CoverPhotoUploader
  
end

class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy
  # has_many :pastings, dependent: :destroy

  accepts_nested_attributes_for :photos, allow_destroy: true,
                                  reject_if: lambda {|x| !x[:image].present?}

  validates :title, uniqueness: {scope: :user_id}, presence: true
  validates :photos, presence: true

  def recent_five
    photos.order("id desc").limit(5)
  end

end

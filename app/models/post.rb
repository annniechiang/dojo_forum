class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader 

  has_many :replies, dependent: :destroy
  has_many :collects, dependent: :destroy

  belongs_to :user
  belongs_to :category

  def count_views
    self.viewed_count += 1
    self.save
  end

end

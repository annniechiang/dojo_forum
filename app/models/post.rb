class Post < ApplicationRecord
  mount_uploader :photo, PostPhotoUploader 

  has_many :replies, dependent: :destroy
  has_many :collects, dependent: :destroy

  belongs_to :user
end

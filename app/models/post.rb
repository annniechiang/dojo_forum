class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader 

  has_many :replies, dependent: :destroy
  has_many :collects, dependent: :destroy

  belongs_to :user
  belongs_to :category
end

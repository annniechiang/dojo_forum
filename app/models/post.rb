class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader 
  validates_presence_of :title, :content

  has_many :replies, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collect_users, through: :collects, source: :user

  belongs_to :user
  belongs_to :category

  def count_views
    self.viewed_count += 1
    self.save
  end

  def is_collected?(user)
    self.collect_users.include?(user)
  end
end

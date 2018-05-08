class Post < ApplicationRecord
  has_many :replies, dependent: :destroy
  has_many :collects, dependent: :destroy

  belongs_to :user
end

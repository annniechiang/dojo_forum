class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  mount_uploader :avatar, AvatarUploader

  has_many :posts, dependent: :destroy

  has_many :replies, dependent: :destroy
  has_many :replied_posts, through: :replies, source: :post

  has_many :collects, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  def admin?
    self.role == "admin"
  end
end

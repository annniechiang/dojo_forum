class User < ApplicationRecord

  before_create :generate_authentication_token
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
  has_many :collected_posts, through: :collects, source: :post

  # 自己發出並被同意的邀請
  has_many :friendships, -> {where status: true}, dependent: :destroy
  has_many :friends, through: :friendships
  # 對方發出並已同意的邀請
  has_many :inverse_friendships, -> {where status: true}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  # 自己發出並尚未同意的邀請
  has_many :waiting_accept_friendships, -> {where status: false}, class_name: "Friendship", dependent: :destroy
  has_many :waiting_accept_friends, through: :waiting_accept_friendships, source: :friend
  # 對方發出並尚未同意的邀請
  has_many :waiting_response_friendships, -> {where status: false}, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :waiting_response_friends, through: :waiting_response_friendships, source: :user

  def admin?
    self.role == "admin"
  end

  def my_friend?(user)
    self.friends.include?(user) || self.inverse_friends.include?(user)
  end

  def wait_for_accept_friend?(user)
    self.waiting_accept_friends.include?(user)
  end

  def wait_for_response_friend?(user)
    self.waiting_response_friends.include?(user)
  end

  def generate_authentication_token
     self.authentication_token = Devise.friendly_token
  end

end

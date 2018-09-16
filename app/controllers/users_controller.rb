class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :comments, :collects, :drafts, :friends]

  def show
    @posts = @user.posts.all.order("posts.created_at DESC")
  end

  def comments
    @posts = @user.replied_posts.all.order("posts.created_at DESC")
    @replies = @user.replies.all.order("replies.created_at DESC")
  end

  def collects
    @posts = @user.collected_posts.all.order("posts.created_at DESC")
  end

  def drafts
  end

  def friends
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end

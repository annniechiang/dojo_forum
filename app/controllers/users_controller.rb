class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :comments, :collects, :drafts, :friends]

  def show
    @posts = @user.posts.where(status: true).order("posts.created_at DESC")
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Successfully updated"
      redirect_to user_path(@user)
    else
      flash[:notice] = "Failed to update"
      render :edit 
    end
  end

  def comments
    @replies = @user.replies.all.order("replies.created_at DESC")
  end

  def collects
    @collects = @user.collects.all.order("collects.created_at DESC")
  end

  def drafts
    @posts = @user.posts.where(status: false).order("posts.created_at DESC")
  end

  def friends
    @waitings = @user.waiting_accept_friends.all
    @requests = @user.waiting_response_friends.all
    @friends = @user.friends.all + @user.inverse_friends.all
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :intro)
  end

end

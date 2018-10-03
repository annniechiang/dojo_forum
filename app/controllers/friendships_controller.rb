class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:friend_id])
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @friendship.status = false

    @f1 = Friendship.where(user_id: current_user, friend_id: params[:friend_id]).first
    @f2 = Friendship.where(user_id: params[:friend_id], friend_id: current_user).first

    if @f1 == nil && @f2 == nil
      @friendship.save
    end
  end

  def update
    @user = User.find(params[:id])
    @friendship = Friendship.where(user_id: params[:id], friend_id: current_user).first
    @friendship.status = true
    @friendship.save
  end

  def destroy
    @user = User.find(params[:id])
    if params[:name] == "Unfriend"
      @friendship = current_user.friendships.where(friend_id: params[:id]).first
      if @friendship == nil
        @friendship = Friendship.where(user_id: params[:id], friend_id: current_user).first
      end
    elsif params[:name] == "Ignore"
      @friendship = Friendship.where(user_id: params[:id], friend_id: current_user).first
    end
      
    @friendship.destroy
  end
end

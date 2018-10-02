class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:friend_id])
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @friendship.status = false

    if @friendship.save
      # redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      # redirect_back(fallback_location: root_path)
    end
  end

  def update
    @friendship = Friendship.where(user_id: params[:id], friend_id: current_user).first
    @friendship.status = true
    @friendship.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if params[:name] == "Unfriend"
      @friendship = current_user.friendships.where(friend_id: params[:id]).first
    elsif params[:name] == "Ignore"
      @friendship = Friendship.where(user_id: params[:id], friend_id: current_user).first
    end
      
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end
end

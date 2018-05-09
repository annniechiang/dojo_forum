class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.page(params[:page]).per(20)
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Successfully updated"
      redirect_to post_path(@post)
    else
      flash[:notice] = "Failed to update"
      render :edit 
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :photo)
  end
end

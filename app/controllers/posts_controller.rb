class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.page(params[:page]).per(20)
  end

  def new 
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post was successfully created"
      redirect_to posts_path
    else
      flash[:notice] = "Post was failed to create"
      render :new 
    end
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

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :photo, :category_id)
  end
end

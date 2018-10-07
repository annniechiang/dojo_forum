class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy, :collect, :uncollect]

  def index
    @q = Post.where(status: true).ransack(params[:q])
    @posts = @q.result.page(params[:page]).per(20)
    @categories = Category.all
  end

  def show
    @replies = @post.replies.all.page(params[:page]).per(20)
    @reply = Reply.new

    # count views
    @post.count_views
  end

  def new 
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if params[:commit] == "Save Draft"
      @post.status = false
    else
      @post.status = true
    end

    if @post.save
      @post.last_replied_at = @post.created_at
      @post.save
      
      flash[:notice] = "Post was successfully created"
      redirect_to posts_path
    else
      flash[:notice] = "Post was failed to create"
      render :new 
    end
  end

  def update
    if params[:commit] == "Save Draft"
      @post.status = false
    else
      @post.status = true
    end
    
    if @post.update(post_params)
      flash[:notice] = "Successfully updated"
      redirect_to post_path(@post)
    else
      flash[:notice] = "Failed to update"
      render :edit 
    end
  end

  def destroy
    if current_user == @post.user || current_user.admin?
      @post.destroy
      redirect_to posts_path
    end
  end

  def collect
    current_user.collects.create(post: @post)
    @flag = params[:flag]
  end

  def uncollect
    @collect = Collect.where(user: current_user, post: @post)
    @id = @collect[0].id
    @flag = params[:flag]
    @collect.destroy_all
  end

  def feeds
    @posts = Post.all
    @users = User.all
    @categories = Category.all
    @comments = Reply.all

    @popular_posts = Post.all.order("posts.replies_count DESC").limit(10)
    @popular_users = User.all.order("users.user_replies_count DESC").limit(10)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :photo, :category_id, :authority)
  end
end

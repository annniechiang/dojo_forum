class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, :except => [:index]

  def index
    @posts = Post.all
    render json: {
      data: @posts
    }
  end

  def show
    @post = Post.find_by(id: params[:id])
    if !@post
      render json: {
        message: "Can't find the post!",
        status: 400
      }
    else
      if current_user.admin? || current_user == @post.user || @post.authority == "All" || (@post.authority == "Friend" && @post.user.my_friend?(current_user))
        render json: {
          data: @post
        }
      else
        render json: {
          message: "無瀏覽此文章權限!"
        }
      end
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.status = true
    if @post.save
      render json: {
        message: "Post created successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      render json: {
        message: "Post updated successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    render json: {
      message: "Post destroy successfully!"
    }
  end

  private

  def post_params
    params.permit(:title, :content, :photo, :authority, :status, :category_id)
  end
end

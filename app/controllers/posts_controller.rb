class PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(20)
  end
end

class Admin::PostsController < Admin::BaseController

  def index
    @posts = Post.all
  end
  
end

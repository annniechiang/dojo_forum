class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @posts = Post.all
  end
end

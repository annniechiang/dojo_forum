class CategoriesController < ApplicationController

  def show
    @categories = Category.all
    @category = Category.find(params[:id])

    @q = @category.posts.ransack(params[:q])
    @posts = @q.result.page(params[:page]).per(20)
  end

end

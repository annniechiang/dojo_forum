class RepliesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])

    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    @reply.save

    @post.last_replied_at = @reply.created_at
    @post.save
  end

  def edit
    @post = Post.find(params[:post_id])
    @reply = Reply.find(params[:id])
    @flag = params[:flag]
  end

  def update
    @post = Post.find(params[:post_id])
    @reply = Reply.find(params[:id])
    @flag = params[:flag]

    @reply.update_attributes(reply_params)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @reply = Reply.find(params[:id])
    @flag = params[:flag]

    if current_user == @reply.user
      @reply.destroy
    end
  end

  private

  def reply_params
    params[:reply].permit(:content)
  end

end

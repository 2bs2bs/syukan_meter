class CommentsController < ApplicationController
  before_action :require_login, only: %i[create update destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def update
    @comment = current_user.comment.find(params[:id])
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end

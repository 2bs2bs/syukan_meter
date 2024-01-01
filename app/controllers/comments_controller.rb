class CommentsController < ApplicationController
  before_action :require_login, only: [:create :edit :update :destroy]

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to post_path(comment.post), success: 'コメントしました'
    else
      redirect_to post_path(comment.post), danger: 'wei, コメントせんかい'
    end
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

class PostsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    @posts = Post.includes(:comments, :bookmarks, user: :profile).order(created_at: :desc)
    @posts = @posts.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, success: t('.success')
    else
      redirect_to posts_path, danger: t('.failure')
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to posts_path, success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def destroy
    post = current_user.posts.find(params[:id])
  
    post.destroy!
    redirect_to posts_path, success: t('.success')
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end

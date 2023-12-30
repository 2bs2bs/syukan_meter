class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user) 
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      redirect_to posts_path, success: 'post sucess'
    else
      flash.now[danger] = '文字を入れろ'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to posts_path, success: 'post update'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(:id)
  end

  def destroy
    post = current_user.posts.find(params[:id])
  
    post.destroy!
    redirect_to posts_path, success: 'post is delete!'
  end
  private

  def post_params
    params.require(:post).permit(:body)
  end
end

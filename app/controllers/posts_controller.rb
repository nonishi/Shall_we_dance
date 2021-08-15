class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      if current_user.target = true
        flash[:notice] = "パートナーを募集しました。"
      else
        flash[:notice] = "リーダーを募集しました。"
      end
      redirect_to post_path(post)
    else
      @post = post
      render 'new'
    end
  end

  def index
    @posts = Post.page(params[:page]).order(params[:sort])
    @users = User.page(params[:page]).order(params[:sort])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      flash[:notice] = "募集要項を更新しました。"
      redirect_to post_path(post)
    else
      @post = user
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:min_age, :max_age, :min_height, :max_height, :status, :directionality, :experience, :place, :frequency, :comment)
  end
end

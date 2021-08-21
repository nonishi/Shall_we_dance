class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      if current_user.target == true
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
    @search_params = {}
    @all_posts = Post.all
    @posts = Post.includes(:user).page(params[:page])
    if params[:sort].present?
      case params[:sort]
      when 'new'
        @posts = @posts.order(:created_at, :desc)
      when 'old'
        @posts = @posts.order(:created_at, :asc)
      when 'old_age'
        @posts = @posts.order('users.age DESC')
      when 'young'
        @posts = @posts.order('users.age ASC')
      when 'high'
        @posts = @posts.order('users.height DESC')
      when 'low'
        @posts = @posts.order('users.height ASC')
      when 'long'
        @posts = @posts.order('users.experience DESC')
      when 'short'
        @posts = @posts.order('users.experience ASC')
      end
    else
      @posts = @posts.order(:created_at, :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
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

  def search
    @search_params = post_search_params
    @all_posts = Post.includes(:user).search(post_search_params)
    byebug
    if params[:sort].present?
      case params[:sort]
      when 'new'
        @posts = @all_posts.order(:created_at, :desc)
      when 'old'
        @posts = @all_posts.order(:created_at, :asc)
      when 'old_age'
        @posts = @all_posts.order('users.age DESC')
      when 'young'
        @posts = @all_posts.order('users.age ASC')
      when 'high'
        @posts = @all_posts.order('users.height DESC')
      when 'low'
        @posts = @all_posts.order('users.height ASC')
      when 'long'
        @posts = @all_posts.order('users.experience DESC')
      when 'short'
        @posts = @all_posts.order('users.experience ASC')
      end
    else
      @posts = @all_posts.order(:created_at, :desc)
    end
    # @posts = @all_posts.page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:min_age, :max_age, :min_height, :max_height, :status, :directionality, :experience, :place, :frequency, :comment)
  end

  def post_search_params
    params.fetch(:search, {}).permit(:target, :status, :height_from, :height_to, :age_from, :age_to, :area)
  end
end

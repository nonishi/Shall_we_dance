class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @unchecked_notifications = current_user.passive_notifications.where(checked: false)
    if @user.post
      from_height = @user.post.min_height ||= 100
      to_height = @user.post.max_height ||= 200
      from_age = @user.post.min_age ||= 1
      to_age = @user.post.max_age ||= 100
      @recommend_users = User.where(
        height: from_height..to_height,
        age: from_age..to_age,
        target: !@user.target,
        area: @user.area
      ).where.not(id: current_user.id).sample(5)
    else
      @recommend_users = []
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "プロフィールを更新しました。"
      redirect_to user_path(user)
    else
      @user = user
      render :edit
    end
  end

  def favorites
    user = User.find(params[:id])
    @posts = user.favorite_posts
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :is_active, :name, :status, :age, :height, :area, :experience, :introduction)
  end
end

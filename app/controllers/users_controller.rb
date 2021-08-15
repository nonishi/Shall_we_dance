class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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

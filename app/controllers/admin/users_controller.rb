class Admin::UsersController < ApplicationController
  
  def index
    @users = User.page(params[:page]).per(20)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    if customer.update(customer_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to admin_user_path(user)
    else
      @customer = Customer.find(params[:id])
      flash[:notice] = "情報更新に失敗しました"
      render "edit"
    end
  end
  
end

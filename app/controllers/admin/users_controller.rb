class Admin::UsersController < ApplicationController
  before_action :admin_check
  before_action :set_user, only: %i[ show edit update destroy]

  def index
    @users = User.all.includes(:tasks)
  end
  def show
    @tasks = @user.tasks
  end
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"ユーザーを登録しました"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを更新しました"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました"
    else
      redirect_to admin_users_path, notice: "管理者がいなくなるので削除できません"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def admin_check
    unless current_user && current_user.admin?
      redirect_to root_path, notice: "管理者以外はアクセスできません"
    end
  end
end
class Admin::UsersController < ApplicationController
  before_action :admin_required, only: [:index, :new, :edit, :show]


  def index
    @users = User.all
  end

  def new
    @user = User.new
    
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      flash[:primary] = 'ユーザを登録しました'
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def edit
    @user = User.find(params[:id])
  end

  def update    
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザを更新しました'
      redirect_to admin_users_path
    else
      flash[:warning] = '管理者権限を持つアカウントが0件になるため更新できません' if @user.errors.any?
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:danger] = 'ユーザを削除しました'
      redirect_to admin_users_path
    else
      flash[:warning] = '管理者権限を持つアカウントが0件になるため削除できません'
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def admin_required
    redirect_to tasks_path, flash: {warning: "管理者以外はアクセスできません"} unless user_admin?
  end
end
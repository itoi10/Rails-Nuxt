class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザー登録時にログインする
      log_in @user
      flash[:success] = "ようこそ!サンプルアプリへ"
      # redirect_to user_url(@user) と等価
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  # 編集ページ
  def edit
    @user = User.find(params[:id])
  end

  # 編集処理
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end

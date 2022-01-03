class UsersController < ApplicationController
  # 特定のメソッドでログイン済みユーザーか検証を行う
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # 編集対象が正しいユーザーか検証
  before_action :correct_user,   only: [:edit, :update]
  # 管理者のみ削除可能
  before_action :admin_user,     only: :destroy

  def index
    # https://github.com/kaminari/kaminari
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page])
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
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  # ユーザー削除（管理者のみ）
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end

    # beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

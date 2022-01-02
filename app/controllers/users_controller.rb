class UsersController < ApplicationController
  # 特定のメソッドでログイン済みユーザーか検証を行う
  before_action :logged_in_user, only: [:edit, :update]
  # 編集対象が正しいユーザーか検証
  before_action :correct_user,   only: [:edit, :update]

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

    # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        # 閲覧しようとしたページを記憶
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end

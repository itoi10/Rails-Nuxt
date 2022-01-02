class SessionsController < ApplicationController

  # ログインページ
  def new
  end

  # ログイン
  def create
    # ユーザーをデータベースから見つけて検証する
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # ユーザーログイン
      log_in user
      # チェックボックス オンならユーザーのセッションを永続的にする
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # ユーザーログイン後に、ユーザーページまたはログイン前に閲覧しようとしたページにリダイレクト
      redirect_back_or user
    else
      # flashをflash.nowに置き換えると、レンダリングが終わっているページでフラッシュメッセージを表示することができる
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています'
      render 'new', status: :unprocessable_entity
    end
  end

  # ログアウト (セッション破棄)
  def destroy
    # ログイン中の場合のみログアウトする
    log_out if logged_in?
    redirect_to root_url
  end
end

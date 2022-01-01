class SessionsController < ApplicationController

  # ログインページ
  def new
  end

  # ログイン
  def create
    # ユーザーをデータベースから見つけて検証する
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      remember user # ユーザーのセッションを永続的にする
      redirect_to user # user_url(user)
    else
      # flashをflash.nowに置き換えると、レンダリングが終わっているページでフラッシュメッセージを表示することができる
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています'
      render 'new', status: :unprocessable_entity
    end
  end

  # ログアウト (セッション破棄)
  def destroy
    log_out
    redirect_to root_url
  end
end

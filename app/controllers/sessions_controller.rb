class SessionsController < ApplicationController
  def new
  end

  def create
    # ユーザーをデータベースから見つけて検証する
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      redirect_to user # user_url(user)
    else
      # flashをflash.nowに置き換えると、レンダリングが終わっているページでフラッシュメッセージを表示することができる
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end
end

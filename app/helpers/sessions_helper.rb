module SessionsHelper
  # ブラウザ内の一時cookiesに暗号化済みのユーザーIDが作成される
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す（いる場合）
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  # 「?」はrubyで慣用的に真偽値を返すタイプのメソッドを示すために使われる
  def logged_in?
    !current_user.nil?
  end
end

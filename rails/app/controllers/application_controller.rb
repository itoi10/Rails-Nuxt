class ApplicationController < ActionController::Base
  # APIモードでもCookieを扱う
  # include ActionController::Cookies

  # JWTトークンを検証し正しければ発行主のユーザーを返すモジュール
  include UserAuth::Authenticator

  include SessionsHelper

  private

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        # 閲覧しようとしたページを記憶
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end

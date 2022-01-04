class ApplicationController < ActionController::Base
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

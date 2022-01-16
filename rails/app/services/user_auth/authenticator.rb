# JWTトークンを検証し正しければ発行主のユーザーを返す
module UserAuth
  module Authenticator

    # トークンからcurrent_userを検索し存在しない場合は401を返す
    def authenticate_user
      current_user.presence || unauthorized_user
    end

    # Cookie削除
    def delete_cookie
      return if cookies[token_access_key].blank?
      cookies.delete(token_access_key)
    end

    private

      # リクエストヘッダーからトークンを取得する
      def token_from_request_headers
        request.headers["Authorization"]&.split&.last
      end

      # クッキーのオブジェクトキー(config/initializers/user_auth.rb)
      def token_access_key
        UserAuth.token_access_key
      end

      # トークンの取得(リクエストヘッダー優先)
      def token
        token_from_request_headers || cookies[token_access_key]
      end

      # トークンからユーザーを取得する
      def fetch_entity_from_token
        AuthToken.new(token: token).entity_for_user
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError, JWT::EncodeError
        nil
      end

      # トークンのユーザーを返す
      def current_user
        return if token.blank?
        # @_ メモ用のインスタンス変数と言う意味を明示的にする書き方
        # https://qiita.com/CASIXx1/items/98d31734e26da8982f97
        @_current_user ||= fetch_entity_from_token
      end

      # 401エラーかつCookieを削除する
      def unauthorized_user
        head(:unauthorized) && delete_cookie
      end

  end
end
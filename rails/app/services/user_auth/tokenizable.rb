# JWTトークンの発行と発行主の検索を行う
module UserAuth
  module Tokenizable

    # UserクラスからTokenizableモジュールのメソッドを呼び出せるようにself.includedメソッド作成
    def self.included(base)
      base.extend ClassMethods
    end

    # クラスメソッド
    module ClassMethods

      def from_token(token)
        auth_token = AuthToken.new(token: token)
        from_token_payload(auth_token.payload)
      end

      private
        # トークンをデコードしたpayloadのユーザーID（sub）からユーザーを検索し返す
        def from_token_payload(payload)
          find(payload["sub"])
        end

    end

    # インスタンスメソッド

    # トークンを返す
    def to_token
      AuthToken.new(payload: to_token_payload).token
    end

    # 有効期限付きのトークンを返す
    # セキュリティを考慮して有効期限を短めに設定する必要があるときに使う
    def to_lifetime_token(lifetime)
      auth = AuthToken.new(lifetime: lifetime, payload: to_token_payload)
      { token: auth.token, lifetime_text: auth.lifetime_text }
    end

    private
      def to_token_payload
        { sub: id }
      end

  end
end
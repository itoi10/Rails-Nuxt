require 'jwt'

# トークン発行とデコードを行うクラス
# Zeitwerkの仕様でファイルパスと一致するクラスを宣言しないと正しく読み込まれない
module UserAuth
  class AuthToken
    attr_reader :token
    attr_reader :payload
    attr_reader :lifetime

    # 初期化時アクション
    def initialize(lifetime: nil, payload: {}, token: nil, options: {})
      if token.present?
        @payload, _ = JWT.decode(token.to_s, decode_key, true, decode_options.merge(options))
        @token = token
      else
        @lifetime = lifetime || UserAuth.token_lifetime
        @payload = claims.merge(payload)
        @token = JWT.encode(@payload, secret_key, algorithm, header_fields)
      end
    end

    private
      # エンコードキー(config/initializers/user_auth.rb)
      def secret_key
        UserAuth.token_secret_signature_key.call
      end

      # デコードキー(config/initializers/user_auth.rb)
      def decode_key
        UserAuth.token_public_key || secret_key
      end

      # アルゴリズム(config/initializers/user_auth.rb)
      def algorithm
        UserAuth.token_signature_algorithm
      end

      # オーディエンスの値がある場合にtrueを返す
      def verify_audience?
        UserAuth.token_audience.present?
      end

      # オーディエンス(config/initializers/user_auth.rb)
      def token_audience
        verify_audience? && UserAuth.token_audience.call
      end

      # トークン有効期限を秒数で返す
      def token_lifetime
        @lifetime.from_now.to_i
      end

      # デコード時オプション
      # JWT::DefaultOptions https://www.rubydoc.info/github/jwt/ruby-jwt/master/JWT/DefaultOptions
      # payloadにオーディエンスの値が含まれることを担保するだけでセキュリティを高くするものではない.
      # JWTのセキュリティは署名鍵と有効期限をどう実装するかで決まる
      def decode_options
        {
          aud: token_audience,
          verify_aud: verify_audience?,
          algorithm: algorithm
        }
      end

      # デフォルトクレーム
      # クレームはpayloadに含める値. 有効期限(expiration)と受信者(audience)の値を含める
      def claims
        # アンダーバーから始まる変数はローカル変数であることを明示的にする書き方
        _claims = {}
        _claims[:exp] = token_lifetime
        _claims[:aud] = token_audience if verify_audience?
        _claims
      end

      # エンコード時のヘッダー
      # "typ" (Type) ヘッダ・パラメータ https://openid-foundation-japan.github.io/draft-ietf-oauth-json-web-token-11.ja.html#typHdrDef
      def header_fields
        { typ: "JWT" }
      end
  end
end
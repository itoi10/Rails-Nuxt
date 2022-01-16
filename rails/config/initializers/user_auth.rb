# JWT設定ファイル
module UserAuth
  # Railsモジュール用アクセサメソッド
  mattr_accessor :token_lifetime
  # JWT有効期限のデフォルト値. セキュリティを高めたい場合は、短い有効期限の方が良い
  self.token_lifetime = 2.week

  # トークンを受け取る者の情報
  mattr_accessor :token_audience
  self.token_audience = -> {
    ENV["APP_URL"]
  }

  #  署名アルゴリズム
  mattr_accessor :token_signature_algorithm
  self.token_signature_algorithm = "HS256"

  # 署名に使用する鍵. Railsのシークレットキーを使用
  mattr_accessor :token_secret_signature_key
  self.token_secret_signature_key = -> {
    Rails.application.credentials.secret_key_base
  }

  # 公開鍵を使用する場合はここに指定. 署名アルゴリズムがHS256の場合は使用しない
  mattr_accessor :token_public_key
  self.token_public_key = nil

  # Cookieに保存する際のオブジェクトキーを指定. CookieからJWTを取得する場合はcookies[:access_token]となる
  mattr_accessor :token_access_key
  self.token_access_key = :access_token

  # ログインユーザーが見つからない場合のRailsの例外を指定する
  mattr_accessor :not_found_exception_class
  self.not_found_exception_class = ActiveRecord::RecordNotFound
end
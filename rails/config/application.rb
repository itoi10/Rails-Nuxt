require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # JavaScriptが無効になっていたときのための設定
    # 認証トークンをremoteフォームに埋め込む
    config.action_view.embed_authenticity_token_in_remote_forms = true

    # RailsアプリのTZ設定 TimeWithZone デフォルトはUTC (ENV["TZ"] = JST)
    config.time_zone = ENV["TZ"]

    # DB読み書きに使用するTZ. DBのTZ(UTC)で書き込まれ,RailsのTZ(JST)で読み込まれる
    config.active_record.default_timezone = :utc

    # i18nロケールファイル
    config.i18n.default_locale = :ja

    # Zeiwerk有効時false推奨
    config.add_autoload_paths_to_load_path = false

    # Rails による API 専用アプリケーション
    # https://railsguides.jp/api_app.html
    # config.api_only = true
  end
end

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    config.load_defaults 6.1

    config.generators do |g|
      # Rspec
      g.test_framework :rspec,
        # テストDBにレコードを作成するファイルを作成をしない
        fixtures: false,
        # ビュースペック作成しない
        view_specs: false,
        # ヘルパーファイル用のスペックを作成しない
        helper_specs: false,
        # ルーティング用のスペックを作成しない
        routing_specs: false
    end

  end
end

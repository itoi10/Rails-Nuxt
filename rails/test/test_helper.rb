ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # seeds.rb
  # parallelize_setup do |worker|
  #   load "#{Rails.root}/db/seeds.rb"
  # end

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # fixtures
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include ApplicationHelper

  # Add more helper methods to be used by all tests here...

  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end

  # テストユーザーとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end

  # アクティブなユーザーを一人取り出す
  def active_user
    User.find_by(activated: true)
  end

  def api_url(path = '/')
    "#{ENV['BASE_URL']}/api/v1#{path}"
  end

  # コントローラーのJSONレスポンスを受け取る
  def response_body
    JSON.parse(@response.body)
  end

  # テスト用Cookie（Rack::Test::CookieJar Class）にトークンを保存する
  def logged_in(user)
    cookies[UserAuth.token_access_key] = user.to_token
  end
end

class ActionDispatch::IntegrationTest
  # テストユーザーとしてログインする
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path params: { session: { email: user.email,
                                         password: password,
                                         remember_me: remember_me } }
  end
end

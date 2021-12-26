require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
  end

  test "should get about" do
    # aboutページにGETリクエストを送る
    get static_pages_about_url
    # 200 OKが返ること
    assert_response :success
  end
end
require 'test_helper'

class AuthenticatorTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @token = @user.to_token
  end

  # JWTデコードデータテスト
  test "jwt_decode" do
    payload = UserAuth::AuthToken.new(token: @token).payload
    sub = payload["sub"]
    exp = payload["exp"]
    aud = payload["aud"]

    # subjectは一致しているか
    assert_equal(@user.id, sub)

    # expirationの値はあるか
    assert exp.present?

    # tokenの有効期限は2週間か(1分許容)
    assert_in_delta(2.week.from_now, Time.at(exp), 1.minute)

    # audienceの値はあるか
    assert aud.present?

    # audienceの値は一致しているか
    assert_equal(ENV["APP_URL"], aud)
  end

end
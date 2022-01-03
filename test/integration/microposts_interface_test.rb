require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'ul.pagination'

    # 無効な送信
    assert_no_difference 'Micropost.count' do
      post microposts_path params: { micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'  # エラー表示
    assert_select 'a[rel="next"]'          # 次ページリンク

    # 有効な送信
    content = "This micropost really ties the room together"
    assert_difference 'Micropost.count', 1 do
      post microposts_path params: { micropost: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body

    # 投稿を削除する
    assert_select 'a', text: '削除'
    first_micropost = @user.microposts.page(1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end

    # 違うユーザーのプロフィールにアクセス（削除リンクがないことを確認）
    get user_path(users(:archer))
    assert_select 'a', text: '削除', count: 0
  end
end
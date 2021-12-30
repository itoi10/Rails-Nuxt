require 'rails_helper'
RSpec.describe "UsersSignupTest", type: :feature do
  scenario 'invalid signup information' do
    visit signup_path
    fill_in 'ユーザーネーム', with: ' '
    fill_in 'メールアドレス', with: 'user@invalid'
    fill_in 'パスワード', with: 'foo'
    fill_in 'パスワード（確認）', with: 'bar'
    click_on 'アカウント作成'
    aggregate_failures do
      expect(current_path).to eq users_path
      expect(page).to have_content 'サインアップ'
      expect(page).to have_content 'The form contains 4 errors'
    end
  end
end
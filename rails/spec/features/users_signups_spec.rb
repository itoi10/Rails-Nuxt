require 'rails_helper'
RSpec.describe 'UsersSignupTest', type: :feature do
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

  scenario 'create new data when user submits valid information' do
    visit signup_path
    expect do
      fill_in 'ユーザーネーム', with: 'テストユーザー'
      fill_in 'メールアドレス', with: 'test1@example.com'
      fill_in 'パスワード', with: 'testpassword'
      fill_in 'パスワード（確認）', with: 'testpassword'
      click_on 'アカウント作成'
    end.to change(User, :count).by(1)

    aggregate_failures do
      expect(current_path).to eq user_path(User.last)
      expect(has_css?('.alert-success')).to be_truthy
      visit current_path
      expect(has_css?('.alert-success')).to be_falsy
    end
  end
end

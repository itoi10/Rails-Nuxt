require 'rails_helper'

RSpec.describe "UsersLogins", type: :feature do
  scenario 'login with valid email/invalid password' do
    visit login_path
    fill_in 'メールアドレス', with: 'valid@example.com'
    fill_in 'パスワード', with: ' '
    click_button 'ログイン'
    aggregate_failures do
      expect(current_path).to eq login_path
      expect(has_css?('.alert-danger')).to be_truthy
      visit current_path
      expect(has_css?('.alert-danger')).to be_falsy
    end
  end
end
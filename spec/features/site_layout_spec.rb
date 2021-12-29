require 'rails_helper'

RSpec.describe "SiteLayoutTest", type: :feature do
  before { visit root_path }
  subject { page }
  scenario "layout links" do
    # リンク
    is_expected.to have_link nil, href: root_path, count: 2
    is_expected.to have_link nil, href: help_path
    is_expected.to have_link nil, href: about_path
    is_expected.to have_link nil, href: contact_path
    # タイトル
    visit contact_path
    expect(page).to have_title full_title("Contact")
  end
end
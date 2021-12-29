require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  describe "Home page" do
    it "returns http success and title ok" do
      get root_path
      expect(response).to have_http_status(:success)
      assert_select "title", full_title
    end
  end

  describe "Help page" do
    it "returns http success and title ok" do
      get help_path
      expect(response).to have_http_status(:success)
      assert_select "title", full_title("Help")
    end
  end

  describe "About page" do
    it "returns http success and title ok" do
      get about_path
      expect(response).to have_http_status(:success)
      assert_select "title", full_title("About")
    end
  end

  describe "Contact page" do
    it "returns http success and title ok" do
      get contact_path
      expect(response).to have_http_status(:success)
      assert_select "title", full_title("Contact")
    end
  end
end

require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  before do
    @base_title = "Sample App"
  end

  describe "GET /" do
    it "response 200 OK and title ok" do
      get root_url
      expect(response).to have_http_status(200)
      assert_select "title", "Home | #{@base_title}"
    end
  end

  describe "GET /static_pages/home" do
    it "response 200 OK and title ok" do
      get static_pages_home_path
      expect(response).to have_http_status(200)
      assert_select "title", "Home | #{@base_title}"
    end
  end

  describe "GET /static_pages/help" do
    it "response 200 OK and title ok" do
      get static_pages_help_path
      expect(response).to have_http_status(200)
      assert_select "title", "Help | #{@base_title}"
    end
  end

  describe "GET /static_pages/about" do
    it "response 200 OK and title ok" do
      get static_pages_about_path
      expect(response).to have_http_status(200)
      assert_select "title", "About | #{@base_title}"
    end
  end

  describe "GET /static_pages/contact" do
    it "response 200 OK and title ok" do
      get static_pages_contact_path
      expect(response).to have_http_status(200)
      assert_select "title", "Contact | #{@base_title}"
    end
  end
end

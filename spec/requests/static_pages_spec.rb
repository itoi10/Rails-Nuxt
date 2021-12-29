require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  before do
    @base_title = "Sample App"
  end

  describe "should get home" do
    it "response 200 OK and title ok" do
      get root_path
      expect(response).to have_http_status(200)
      assert_select "title", "#{@base_title}"
    end
  end

  describe "should get help" do
    it "response 200 OK and title ok" do
      get help_path
      expect(response).to have_http_status(200)
      assert_select "title", "Help | #{@base_title}"
    end
  end

  describe "should get about" do
    it "response 200 OK and title ok" do
      get about_path
      expect(response).to have_http_status(200)
      assert_select "title", "About | #{@base_title}"
    end
  end

  describe "should get contact" do
    it "response 200 OK and title ok" do
      get contact_path
      expect(response).to have_http_status(200)
      assert_select "title", "Contact | #{@base_title}"
    end
  end
end

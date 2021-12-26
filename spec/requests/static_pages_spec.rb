require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  describe "GET /static_pages/home" do
    it "response 200 OK" do
      get static_pages_home_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /static_pages/help" do
    it "response 200 OK" do
      get static_pages_help_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /static_pages/abount" do
    it "response 200 OK" do
      get static_pages_about_path
      expect(response).to have_http_status(200)
    end
  end
end

require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/messages/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/messages/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/messages/edit"
      expect(response).to have_http_status(:success)
    end
  end

end

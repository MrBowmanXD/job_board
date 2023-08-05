require 'rails_helper'

RSpec.describe "Donates", type: :request do
  describe "GET /payment" do
    it "returns http success" do
      get "/donate/payment"
      expect(response).to have_http_status(:success)
    end
  end

end

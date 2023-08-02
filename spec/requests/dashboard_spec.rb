require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /index" do
    it "returns http success" do
      user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password, role: 'job poster')
      sign_in user
      get "/dashboard/index"
      expect(response).to have_http_status(:success)
    end
  end

end

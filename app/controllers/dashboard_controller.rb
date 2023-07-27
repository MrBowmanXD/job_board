class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_profile = User.find(current_user.id)
  end
end

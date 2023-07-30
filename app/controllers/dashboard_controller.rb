class DashboardController < ApplicationController
  before_action :authenticate_user!, only: %i[index, show]

  def index
    @user_profile = User.find(current_user.id)
    @message = Message.new
  end

  def show
    @user_profile = User.find(params[:id])
  end
end

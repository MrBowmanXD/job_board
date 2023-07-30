class DashboardController < ApplicationController
  before_action :authenticate_user!, only: %i[index, show]

  def index
    if current_user.present?
      @user_profile = User.find(current_user.id)
      @message = Message.new
    else
      redirect_to :root, alert: "You are not signed in.", status: :unauthorized
    end
  end

  def show
    @user_profile = User.find(params[:id])
    @message = Message.new(name: User.where(id: params[:id]).first.name)
  end
end

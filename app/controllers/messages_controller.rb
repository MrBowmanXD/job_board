class MessagesController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  # Post message (post)
  def create
    if params[:message][:name] != current_user.name && User.where(name: params[:message][:name]).first.present?
      @user_id = User.where(name: params[:message][:name]).first.id
      @message = Message.create(message_params) do |m|
        m.user_id = current_user.id
      end
      redirect_to dashboard_path(@user_id)
    else
      if params[:message][:name] == current_user.name
        redirect_to :root, alert: "You are not able to send a message to yourself.", status: :unauthorized
      else
        redirect_to :root, alert: "The user doesn't exist.", status: :unauthorized
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:name, :title, :body)
  end
end

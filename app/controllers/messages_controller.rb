class MessagesController < ApplicationController
  before_action :set_message, only: %i[show edit]
  before_action :authenticate_user!, only: %i[index show create edit update]

  # Show a multitude of messages
  def index
    @messages = Message.where(user_id: params[:user_id])
  end

  # Show an individual message
  def show
  end

  # Post message (post)
  def create
    if params[:message][:name] != current_user.name
      @user_id = User.where(name: params[:message][:name]).first.id
      @message = Message.create(message_params) do |m|
        m.user_id = current_user.id
      end
      redirect_to dashboard_path(@user_id)
    else
      redirect_to :root, alert: "You are not able to send a message to yourself.", status: :unauthorized
    end
  end

  # Get edition form (get)
  def edit
  end

  # Update message (patch)
  def update
  end

  private
  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:name, :title, :body)
  end
end

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
      @message = Message.new(message_params)
      @dashboard = User.find(current_user.id)
      @message.user_id = current_user.id
      if @message.save
        redirect_to dashboard_path(@dashboard), notice: "You were able to send a message"
      else
        redirect_to :root, alert:, status: unprocessable_entity
      end
    else
      redirect_to :root, alert: "You are not allowed to message yourself.", status: :unauthorized
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

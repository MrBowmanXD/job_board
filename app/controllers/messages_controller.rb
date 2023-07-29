class MessagesController < ApplicationController
  before_action :set_message, only: %i[show edit]
  before_action :authenticate_user!, only: %i[index show create edit update]

  def index
    @messages = Message.where(user_id: params[:user_id])
  end

  def show
  end

  # Post message (post)
  def create
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
end

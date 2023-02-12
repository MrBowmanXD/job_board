class UsersController < ApplicationController
  before_action :logged_in?, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Well done, you were able to sign up"
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:alert] = "Ups, something went wrong in the account creation"
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password_digest)
  end

end

class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(user_params)

    if @user
      flash[:notice] = "Well done, you were able to log in"
      if session[:user_id]
        redirect_to User.find(session[:user_id])
      else
        session[:user_id] = @user.id
        redirect_to root_path
      end 
    else
      flash[:alert] = "Ups, something went wrong in the log in"
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to users_url
  end

  private
  def user_params
    params.require(:post).permit(:username, :email, :password_digest)
  end
end

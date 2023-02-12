class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find(params[:id])

    if @user.authenticate
      flash[:notice] = "Well done, you were able to log in"
      if session[:user_id]
        redirect_to @user
      else
        session[:user_id] = @user.id
        redirect_to @user
      end 
    else
      flash.now[:alert] = "Ups, something went wrong in the log in"
      render 'new', status: :unprocessable_entity
    end
    else

    end
  end

  def destroy
    @user = session[:user_id]
    session[:user_id] = nil
  end
end

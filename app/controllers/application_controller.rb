class ApplicationController < ActionController::Base
	

	def logged_in?
		if session[:user_id]
			true
		else
			false
		end
	end
end

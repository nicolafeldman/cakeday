class SessionsController < ApplicationController

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user

		else
			flash.now[:error] = 'Invalid email/password combo, dawg!'
			render 'new'
		end
	end

	def new
	end

	def destroy
	end

end

class UserController < ApplicationController
	
	def show

	end

	def showRegister
	end

	def register
		
		@user = User.new(user_parameters_register)

		@user.save

		redirect_to '/register'
	end

	def check
		params[:user][:password] = Digest::MD5.hexdigest(params[:user][:password])
		authenticated = User.find_by(email: params[:user][:email], password: params[:user][:password])
		if authenticated
			session[:email] = params[:user][:email]

			redirect_to '/profile'
		else
			redirect_to '/login'
		end
	end


	def profile
		@results = User.find_by(email: session[:email])
		if !session[:email]
			puts "Not logged in"
		else
			puts "Logged in"
		end
	end

	def fetch

		@results = User.find_by(email: session[:email])
		
	end

	def test
		
	end


	private

	def user_parameters_register
		params[:user][:password] = Digest::MD5.hexdigest(params[:user][:password])
		params.require(:user).permit(:email, :password, :name, :age)
	end

	def user_parameters
		
		params[:user][:password] = Digest::MD5.hexdigest(params[:user][:password])
		params.require(:user).permit(:email, :password)
	end
end

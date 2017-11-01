class UserController < ApplicationController
	
	def show

	end

	def showRegister
	end

	def register
		
		@user = User.new(user_parameters_register)

		@user.save

		redirect_to '/login'
	end

	def check
		params[:user][:password] = Digest::MD5.hexdigest(params[:user][:password])
		authenticated = User.find_by(email: params[:user][:email], password: params[:user][:password])
		if authenticated
			session[:email] = params[:user][:email]
			session[:id] = authenticated[:id]
			
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
		info = User.find_by(id: params[:id])

		@image = info[:image]
		@name = info[:name]
		@is_friends = false
		result1 = Friend.find_by(fid1: session[:id], fid2: params[:id], accepted: true)
		result2 = Friend.find_by(fid1: params[:id], fid2: session[:id], accepted: true)

		if result1 || result2
			@is_friends = true		
		end
	end

	def addfriend
		alreadyFriends = Friend.find_by(fid1: session[:id], fid2: params[:id])
		alreadyFriends1 = Friend.find_by(fid2: session[:id], fid1: params[:id])
		if alreadyFriends || alreadyFriends1
			msg = {status: false, message: 'Already friends'}
			puts "Already friends"
			render :json => msg
		else
			@friends = Friend.new(:fid1 => session[:id], :fid2 => params[:id], :accepted => false)
			@friends.save
			msg = {status: true, message: 'Friend request sent.'}
			render :json => msg
		end
	end

	def showImages
		@images = Image.where(uid: session[:id])
		puts @images
		render 'images'
	end

	def uploadImages
		auth = {
			cloud_name: "widelyimages",
			api_key: '213415313572913',
			api_secret: "vKwECIDQtisYyi-PbIfjJ-HGFLI",
			enhance_image_tag: true,
			static_image_support: false
		}
		
		uploadStatus = Cloudinary::Uploader.upload(params[:image], :unique_filename => false)


		url = uploadStatus["url"]

		@image = Image.new(uid: session[:id], url: url)

		@image.save

		redirect_to '/images'

	end

	def notifications
		@notifications = Friend.where(fid2: session[:id], accepted: false)
		msg = {requests: @notifications}
		render :json => msg

	end

	def showAllUsers
		
		@all = User.all

		render 'users'
	end

	def accept
		id = params[:id]
		user = Friend.find_by(fid1: id, fid2: session[:id])
		user.accepted = true
		user.save
		msg = {status: true}
		render :json => msg
	end

	private

	def user_parameters_register
		auth = {
			cloud_name: "widelyimages",
			api_key: '213415313572913',
			api_secret: "vKwECIDQtisYyi-PbIfjJ-HGFLI",
			enhance_image_tag: true,
			static_image_support: false
		}
		
		uploadStatus = Cloudinary::Uploader.upload(params[:user][:image], :unique_filename => false)

		params[:user][:password] = Digest::MD5.hexdigest(params[:user][:password])

		params[:user][:image] = uploadStatus["url"]

		params.require(:user).permit(:email, :password, :name, :age, :image)
	end

	def user_parameters
		
		params[:user][:password] = Digest::MD5.hexdigest(params[:user][:password])
		params.require(:user).permit(:email, :password)
	end

end

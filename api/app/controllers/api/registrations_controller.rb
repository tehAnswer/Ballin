class Api::RegistrationsController < Devise::SessionsController

	# POST /api/users
	# POST /api/users.json
	def create
		user = User.new
		user.email = registrations_params[:email]
		user.username = registrations_params[:username]
		user.password = registrations_params[:password]
		if user.valid?
			user.update_auth_code
			user.save
			render json: { token: user.auth_code }, status: 201
		else
			render json: user.errors, status: 422
		end
	end


	private

	 def registrations_params
	 	params.require(:login).permit(:username, :email, :password)
	 end


end
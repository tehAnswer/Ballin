class Api::RegistrationsController < Devise::SessionsController
	respond_to :json

	# POST /api/users
	# POST /api/users.json
	def create
		user = User.new
		user.email = registrations_params[:email]
		user.username = registrations_params[:username]
		user.password = registrations_params[:password]
		if user.valid?
			user.update_auth_code
			respond_with user, status: 201
		else
			respond_with user.errors, status: 422
		end
	end


	private

	 def registrations_params
	 	params.require(:login).permit(:username, :email, :password)
	 end


end
class Api::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user, only: :create

  # POST /api/users/sign_in
  def create
    user = User.find_for_database_authentication(email: params[:email_or_username]) || User.find_for_database_authentication(username: params[:email_or_username])
    password = params[:password]
    unless user && password
      render json: { error: "Missing login data." }, status: 401
      return
    end
    
    if user.valid_password?(password)
      render json: user, status: 201
      return
    else
      render json: { error: "Bad combination." }, status: 401
    end
  end

  # DELETE /api/users/sign_out
  def destroy
  end

end
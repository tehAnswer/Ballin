class Api::SessionsController < Devise::SessionsController

  # POST /api/users/sign_in
  def create
    user = User.find_for_database_authentication(email: params[:email])
    password = params[:password]
    unless user && password
      render json: "Missing data.", status: 401
      return
    end

    puts user.valid_password? password
    if user.valid_password? password
      render json: { token: user.auth_code }, status: 201
      return
    else
      render json: "Bad combination.", status: 401
    end
  end

  # DELETE /api/users/sign_out
  def destroy
  end

end
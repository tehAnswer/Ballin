class Api::SessionsController < Devise::SessionsController
  respond_to :json

  # GET /api/users/sign_in
  def new
    render json:"SHit"
  end

  # POST /api/users/sign_in
  def create
    user = User.find_for_database_authentication(email: params[:user][:email])
    render json:"Not such email.", status: 401 unless user
    if user.valid_password?
      render json: "OK", status: 200
    else
      render json: "Bad combination.", status: 401
    end
  end

  # DELETE /api/users/sign_out
  def destroy
  end

end
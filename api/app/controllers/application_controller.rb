class ApplicationController < ActionController::Base
	include PaginationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  after_filter :set_access_control_headers
  before_action :authenticate_user

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def authenticate_user
    @user = User.find_by(auth_code: request.headers[:dagger])
    render json: { error: "Invalid auth token" }, status: 401 unless @user
  end

end

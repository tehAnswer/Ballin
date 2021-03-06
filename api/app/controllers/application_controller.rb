class ApplicationController < ActionController::Base
	include PaginationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  after_filter :set_access_control_headers
  before_action :authenticate_user
  respond_to :json
  
  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error = {}
    error[parameter_missing_exception.param] = ['parameter is required']
    response = { errors: [error] }
    respond_to do |format|
      format.json { render json: response, status: :unprocessable_entity }
    end
  end

  rescue_from(Neo4j::Session::CypherError) do
    render json: "IDs are not negative, mmkay?", status: 422
  end

  def paginated_response(collection)
    page = request[:page] || 1
    meta = paginate(page, collection)
    collection = collection.paginate(page: page, per_page: BallinAPI::ITEMS_PER_PAGE )
    respond_with collection, meta: meta 
  end

  def coalesce_find_requests_response(klass)
    variable_name = "@#{klass.name.pluralize.underscore}"
    instance_variable_set(variable_name, [])
    params[:ids].each do |id|
      item = klass.find_by(neo_id: id)
      instance_variable_get(variable_name) << item if item
    end if params[:ids]
    render json: instance_variable_get(variable_name)
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def authenticate_user
    @user = User.find_by(auth_code: request.headers[:dagger])
    render json: { error: "Invalid auth token" }, status: 401 unless @user
  end

  def missing_data
    render json: { error: "Missing data" }, status: 422
  end
end

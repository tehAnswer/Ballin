class Api::DivisionsController < ApplicationController
  before_action :set_division, only: [:show]
  
  # GET /api/divisions?ids=...
  def index
    coalesce_find_requests_response(Division)
  end

  def show
    respond_with @division, status: 200
  end
  
 private
  def set_division
    @division = Division.find_by(neo_id: params[:id])
    render json: { error: "There's not such division" }, status: 404 unless @division
  end
end
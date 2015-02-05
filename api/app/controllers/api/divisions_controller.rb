class Api::DivisionsController < ApplicationController
  respond_to :json
  
  # GET /api/conferences?ids=...
  def index
    divisions = []
    params[:ids].each do |id|
      division = Division.find_by(neo_id: id)
      divisions << division if division
    end if params[:ids]
    render json: divisions
  end
end
class Api::ConferencesController < ApplicationController
  respond_to :json
  
  # GET /api/conferences?ids=...
  def index
    conferences = []
    params[:ids].each do |id|
      conference = Conference.find_by(neo_id: id)
      conferences << conference if conference
    end if params[:ids]
    render json: conferences
  end
end
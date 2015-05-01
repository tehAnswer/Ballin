class Api::ConferencesController < ApplicationController
  before_action :set_conference, only: [:show]
  
  # GET /api/conferences?ids=...
  def index
    coalesce_find_requests_response(Conference)
  end

  def show
    respond_with @conference, status: 200
  end

 private
  def set_conference
    @conference = Conference.find_by(neo_id: params[:id])
    render json: { error: "There's not such conference" }, status: 404 unless @conference
  end
end
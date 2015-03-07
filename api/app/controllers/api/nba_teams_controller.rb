class Api::NbaTeamsController < ApplicationController
  respond_to :json
  before_action :set_nba_team, only: [:show]

  def index
    coalesce_find_requests_response(NbaTeam)
  end

  def show
    respond_with @nba_team
  end

 private
  def set_nba_team
    @nba_team = NbaTeam.find_by(neo_id: params[:id])
    render json: { error: "Not such nba team" }, status: 404 unless @nba_team
  end
end
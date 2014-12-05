class Api::BoxScoresController < ApplicationController
  respond_to :json

  # GET /players/:player_id/boxscores
  def index
    @boxscores = Player.find_by(neo_id: request[:player_id]).boxscores
  end

end
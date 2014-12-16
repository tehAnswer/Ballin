class Api::BoxScoresController < ApplicationController
  respond_to :json

  # GET /players/:player_id/boxscores
  def index
    player = Player.find_by(neo_id: request[:player_id])
    if player
      @boxscores = player.boxscores
    else
      render json: "There isn't such player.", status_code: 440
    end 
  end

end
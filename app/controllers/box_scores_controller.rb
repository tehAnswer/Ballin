class BoxScoresController < ApplicationController
  respond_to :json

  def index
    @boxscores = Player.find_by(neo_id: request[:player_id]).boxscores
  end

end
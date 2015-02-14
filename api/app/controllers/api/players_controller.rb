class Api::PlayersController < ApplicationController
  before_action :set_player, only: [:show]
  respond_to :json

  # GET /api/players
  # GET /api/players.json
  def index
    paginated_response(Player.all)
  end

  # GET /api/players/1
  def show
    respond_with @player
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find_by(neo_id: params[:id])
      render json: { error: "Not such player" }, status: 404 unless @player
    end
end

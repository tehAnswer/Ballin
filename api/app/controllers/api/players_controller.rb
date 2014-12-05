class Api::PlayersController < ApplicationController
  before_action :set_player, only: [:show]
  respond_to :json

  # GET /players
  # GET /players.json
  def index
    page = request[:page].to_i || 0
    @players = Player.all.drop(page*BallinAPI::ITEMS_PER_PAGE).take(BallinAPI::ITEMS_PER_PAGE)
  end

  # GET /players/1
  def show
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find_by(neo_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :age, :height_cm, :height_formatted, :weight_lb, :weight_kg, :position, :number, :birthplace, :birthdate, :page)
    end
end

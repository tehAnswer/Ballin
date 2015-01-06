require 'neo4j-will_paginate_redux'

class Api::PlayersController < ApplicationController

  before_action :set_player, only: [:show]
  respond_to :json

  # GET /api/players
  # GET /api/players.json
  def index
    page = request[:page] || 1
    players = Player.all
    meta = paginate(page, players)
    players = players.paginate(page: page, per_page: BallinAPI::ITEMS_PER_PAGE )
    respond_with players, meta: meta
    
  end

  # GET /api/players/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :age, :height_cm, :height_formatted, :weight_lb, :weight_kg, :position, :number, :birthplace, :birthdate, :page)
    end
end

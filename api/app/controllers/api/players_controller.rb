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
    respond_with @player
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find_by(id: params[:id])
      render json: { error: "Not such player"}, status: 404 unless @player
    end
end

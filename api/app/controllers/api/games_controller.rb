class Api::GamesController < ApplicationController
  before_action :set_game, only: [:show]
  respond_to :json

  def index
    if(params[:ids] != nil)
      coalesce_find_requests_response(Game)
    elsif (params[:date_formatted] != nil)
      hash = Hash.new
      hash[:games] = Game.where(date_formatted: params[:date_formatted]).to_a
      respond_with(hash) 
    else
      render json: { errorMessage: "Missing data" }, status: 422
    end
  end

  def show
    respond_with @game
  end

 private
  def set_game
    @game = Game.find_by(neo_id: params[:id])
    render json: { error: "There's not such game" }, status: 404 unless @game
  end
  
end
class Api::LeaguesController < ApplicationController
  before_action :set_league, only: [:show]
  respond_to :json

  # GET /leagues
  def index
    @leagues = League.all
  end

  # GET /leagues/1
  def show
  end

  # POST /leagues
  def create
    @league = LeagueCreation.create(league_params)
    if @league.persisted?
      respond_with(@league)
    else
      respond_with(@league.errors, status: :unprocessable_entity)
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find_by(neo_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      params.require(:league).permit(:name)
    end
end

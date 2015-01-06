class Api::LeaguesController < ApplicationController
  before_action :set_league, only: [:show]
  respond_to :json

  # GET /api/leagues
  def index
    page = request[:page] || 1
    leagues = League.all
    meta = paginate(page, leagues)
    leagues = leagues.paginate(page: page, per_page: BallinAPI::ITEMS_PER_PAGE )
    respond_with leagues, meta: meta
  end

  # GET /api/leagues/1
  def show
  end

  # POST /api/leagues
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
      @league = League.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      params.require(:league).permit(:name, :page)
    end
end

class Api::LeaguesController < ApplicationController
  before_action :set_league, only: [:show]
  respond_to :json

  # GET /api/leagues
  def index
    paginated_response(League.all)
  end

  # GET /api/leagues/1
  def show
    if !@league.nil?
      respond_with @league
    else
      render json: { error: "Not such league" }, status: 404
    end
  end

  # POST /api/leagues
  def create
    unless @user.is_admin
      render json: { error: "Only admins can create leagues." }, status: 403
      return
    end
    @league = LeagueCreation.create(league_params)
    if @league.persisted?
      respond_with @league, location: "api/leagues/#{@league.neo_id}"
    else
      render json: { errors: @league.errors }, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find_by(neo_id: params[:id])
      render json: { error: "Not such league" }, status: 404 unless @league
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      params.require(:league).permit(:name)
    end
end

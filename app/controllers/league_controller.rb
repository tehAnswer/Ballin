class LeagueController < ApplicationController
  respond_to :json

  # GET /leagues
  def index
    @players = Player.all
    respond_with(@players)
  end

  # GET /leagues/1
  def show
    respond_with(@league)
  end

  # POST /leagues
  def create
    @league = LeagueCreation.new (league_params)

    if @league.save
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
      params.require(:league).permit(:name, :password)
    end
end




end

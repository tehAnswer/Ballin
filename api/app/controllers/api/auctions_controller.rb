class Api::AuctionsController < ApplicationController

  # GET /api/leagues/:league_id/auctions
  def index
    paginated_response(@league.auctions)
  end

  # POST /api/leagues/:league_id/auctions
  def create
  end

 private

  def set_league
    @league = League.find_by(neo_id: params[:league_id])
    render json: { error: "There's not such league" }, status: 404 unless @league
  end

  def auction_params
    params.require(:auction).permit(:player_id)
  end 
end

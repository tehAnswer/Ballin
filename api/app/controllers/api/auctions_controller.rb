class Api::AuctionsController < ApplicationController
  before_action :set_league, only: [:index, :create]
  respond_to :json

  # GET /api/leagues/:league_id/auctions
  def index
    paginated_response(@league.auctions)
  end

      # POST /api/leagues/:league_id/auctions
  def create
    auction = AuctionCreation.create(auction_params, @league, @user)
    if auction
      respond_with auction, location: "/api/leagues/#{@league.neo_id}/auctions/#{auction.neo_id}"
    else
      render json: { error: "Invalid operation" }, status: 422
    end
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

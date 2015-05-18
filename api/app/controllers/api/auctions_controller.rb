class Api::AuctionsController < ApplicationController
  before_action :set_league, only: [:create]
  before_action :set_auction, only: [:show]
  respond_to :json

  # GET /api/leagues/:league_id/auctions
  def index
    coalesce_find_requests_response(Auction)
  end

      # POST /api/leagues/:league_id/auctions
  def create
    creation = AuctionCreation.new
    auction = creation.create(auction_params, @league, @user)
    if auction
      respond_with auction, location: "/api/leagues/#{@league.neo_id}/auctions/#{auction.neo_id}"
    else
      render json: creation.errors, status: 422
    end
  end

  def show
    respond_with @auction
  end

 private

  def set_league
    @league = League.find_by(neo_id: params[:league_id])
    render json: { error: "There's not such league" }, status: 404 unless @league
  end

  def set_auction
    @auction = Auction.find_by(neo_id: params[:id])
    render json: { error: "There's not such auction" }, status: 404 unless @auction
  end

  def auction_params
    params.require(:auction).permit(:player_id)
  end 
end

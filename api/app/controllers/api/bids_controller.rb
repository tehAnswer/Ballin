class Api::BidsController < ApplicationController
  respond_to :json

  # GET /api/bids?ids=...
  def index
    coalesce_find_requests_response(Bid)
  end

  # POST /api/bids
  def create
    auction = Auction.find_by(neo_id: bid_params[:auction_id])
    creation = BidCreation.new
    bid_rel = creation.create(auction, bid_params.except(:auction_id), @user)

    if bid_rel && bid_rel.persisted?
      respond_with bid_rel.from_node, location: "api/bids/#{bid_rel.from_node.neo_id}"
    elsif bid_rel
      render json: creation.errors, status: 422
    else
      render json: { errorMessage: "Wrong data" }, status: 422
    end
  end

 private
  def bid_params
    params.require(:bid).permit(:salary, :auction_id)
  end 
end
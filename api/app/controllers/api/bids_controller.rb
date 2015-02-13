class Api::BidsController < ApplicationController

  respond_to :json

  def index
    bids = []
    params[:ids].each do |id|
      bid = Bid.find_by(neo_id: id)
      bids << bid if bids
    end if params[:ids]
    render json: bids
  end

  def create
    auction = Auction.find_by(neo_id: bid_params[:auction_id])
    bid_rel = BidCreation.create(auction, bid_params.except(:auction_id))
    if bid_rel && bid_rel.valid?
      respond_with bid_rel.from_node, location: "api/bids/#{bid_rel.from_node.neo_id}"
    elsif bid_rel
      render json: bid_rel.errors, status: 422
    else
      render json: { errorMessage: "Wrong data" }, status: 422
    end
  end

 private
  def bid_params
    params.require(:bid).permit(:salary, :auction_id)
  end 
end
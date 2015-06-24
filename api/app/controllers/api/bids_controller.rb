class Api::BidsController < ApplicationController
  before_action :set_bid, only: [:show]
  respond_to :json

  # GET /api/bids?ids=...
  def index
    coalesce_find_requests_response(Bid)
  end

  # POST /api/bids
  def create
    auction = Auction.find_by(neo_id: bid_params[:auction_id])
    auction = patch_uuid(auction) if auction.uuid.nil?
    creation = BidCreation.new
    bid_rel = creation.create(auction, bid_params.except(:auction_id), @user)
    if bid_rel && bid_rel.persisted?
      respond_with bid_rel.from_node, location: "api/bids/#{bid_rel.from_node.neo_id}"
    elsif bid_rel
      render json: bid_rel.errors, status: 422
    else
      render json: { errorMessage: creation.errors }, status: 422
    end
  end

  # GET /api/box_scores/1
  def show
    respond_with @bid, status: 200
  end

 private
  def bid_params
    params.require(:bid).permit(:salary, :auction_id)
  end

  def set_bid
    @bid = Bid.find_by(neo_id: params[:id])
    render json: { error: "There's not such bid" }, status: 404 unless @bid
  end

  def patch_uuid(auction)
    params = { auction_id: auction.neo_id, uuid: SecureRandom.uuid }
    Neo4j::Session.query("MATCH (a:Auction) where id(a) = {auction_id} set a.uuid = {uuid}", params)
    Auction.find_by(neo_id: bid_params[:auction_id])
  end
end
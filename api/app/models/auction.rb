class Auction
  include Neo4j::ActiveNode

  property :end_time, type: DateTime
  property :created_at

  has_many :in, :bids, model_class: Bid, rel_class: BidRelation
  has_one :out, :player, model_class: Player
  has_one :out, :league, model_class: League


  def player_id
  	player.nil? ? -1 : player.neo_id
  end

  def league_id
  	league.nil? ? -1 : league.neo_id
  end

  def max_bid
  	bids.order(salary: :desc).first || Bid.new(salary: 0)
  end

  def max_bid_id
  	bid = max_bid
  	bid.nil? ? -1 : bid.neo_id
  end
end

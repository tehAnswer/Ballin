class Auction
  include Neo4j::ActiveNode

  property :end_time, type: DateTime
  property :created_at

  has_many :in, :bids, model_class: Bid, rel_class: BidRelation
  has_one :out, :player, model_class: Player
  has_one :out, :league, model_class: League

end

class Bid
  include Neo4j::ActiveNode

  property :salary, type: Integer, default: 500000
  property :updated_at
  property :created_at

  validates :salary, numericality: { greater_than_or_equal_to: 500000 }

  has_one :out, :team, model_class: FantasticTeam
  has_one :out, :auction, model_class: Auction, rel_class: BidRelation

  def team_id
    team.neo_id
  end

  def auction_id
    auction.neo_id
  end

end

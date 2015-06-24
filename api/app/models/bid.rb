class Bid
  include Neo4j::ActiveNode

  property :salary, type: Integer, default: 1000
  property :updated_at
  property :created_at

  validates :salary, numericality: { greater_than_or_equal_to: 1000 }

  has_one :out, :team, model_class: FantasticTeam, type: 'TEAM'
  has_one :in, :auction, model_class: Auction, rel_class: BidRelation

  def team_id
    team.neo_id
  end

  def auction_id
    auction.neo_id
  end

end

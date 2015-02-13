class BidRelation
  include Neo4j::ActiveRel
  from_class Bid
  to_class Auction

  validate :has_auction
  validate :has_bid
  validate :is_open_auction
  validate :over_max_bid
  

  def is_open_auction
    self.errors.add(:is_open_auction, "The auction ain't open.") if to_node.end_time.past?
  end

  def has_auction
    self.errors.add(:nil_auction, "There is not auction.") if to_node.neo_id.nil?
  end

  def has_bid
    self.errors.add(:has_not_bid, "There is not bid") if from_node.neo_id.nil?
  end

  def over_max_bid
    self.errors.add(:over_max_bid, "You need to increase the max bid in $1000.") if from_node.salary <= to_node.max_bid.salary + 1000
  end


end
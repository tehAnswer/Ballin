class BidRelation
  include Neo4j::ActiveRel
  from_class Bid
  to_class Auction
  

  validate :is_open_auction


  def is_open_auction
    self.errors.add(:is_open_auction, "The auction ain't open.") unless to_node.end_date.past?
  end
  


end
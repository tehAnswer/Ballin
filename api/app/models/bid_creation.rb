class BidCreation
  
  def self.create(auction, params)
    begin
      tx = Neo4j::Transaction.new
      bid = Bid.create(params)
      bid_rel = BidRelation.new(from_node: bid, to_node: auction)
      return bid_rel
    rescue StandardError => e
      tx.failure
      Rails.logger.error e.message
      return false
    ensure
      tx.close()
    end
  end


end
class BidCreation

  attr_accessor :bid, :errors

  def initialize
    self.errors = []
  end

  
  def create(auction, params, user)
    begin
      tx = Neo4j::Transaction.new
      check(user.team.nil?, "You cant make a bid if you have not a team")
      self.bid = Bid.create(params)
      bid_rel = BidRelation.create(from_node: bid, to_node: auction)
      bid.team = user.team
      return bid_rel
    rescue StandardError => e
      tx.failure
      Rails.logger.error e.message
      return false
    ensure
      tx.close()
    end
  end

 private

  def check(condition, message)
    if condition
      errors << message
      raise message
    end
  end

end
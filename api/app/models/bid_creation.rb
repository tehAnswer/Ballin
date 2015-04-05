class BidCreation
  include AbstractTransaction
  attr_accessor :bid

  def create(auction, params, user)
    transaction do
      check(user.team.nil?, "You cant make a bid if you have not a team")
      self.bid = Bid.create!(params)
      bid_rel = BidRelation.create(from_node: self.bid, to_node: auction)
      bid.team = user.team
      return bid_rel
    end
  end
end
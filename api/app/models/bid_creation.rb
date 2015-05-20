class BidCreation
  include AbstractTransaction
  attr_accessor :bid

  def create(auction, params, user)
    transaction do
      check(user.team.nil?, "You cant make a bid if you have not a team")
      check(user.team.budget < params.salary, "You cant make a bid over your budget")
      check(user.team.league != auction.league, "You cant bid in other leagues auction")
      self.bid = Bid.create!(params)
      bid_rel = BidRelation.create(from_node: self.bid, to_node: auction)
      bid.team = user.team
      return bid_rel
    end
  end
end
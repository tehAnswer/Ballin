class AuctionCreation
  include AbstractTransaction
  attr_accessor :auction

  def create(params, league, user)
    transaction do
      team = user.team
      self.auction = Auction.create(end_time: 3.days.from_now)
      player = Player.find_by(neo_id: params[:player_id])
      validations(player, team, league)
      raise "Can't create the auction" unless self.valid?
      make_rels(player, league)
      return auction
    end
  end

 private

  def validations(player, team, league)
    check_if_not(player, "There is not such player")
    check_if_not(team.has_contract_with?(player), "You cant sell player that you don't own")
    check_if(team.league != league, "You cant sell players in other league")
    check_if(league.has_auction?(player), "You cant sell the same player twice")
  end

  def make_rels(player, league)
    auction.player = player
    auction.league = league
  end
end
class AuctionCreation

  attr_accessor :errors, :auction

  def initialize
    self.errors = []
  end

  def create(params, league, user)
    begin
      tx = Neo4j::Transaction.new
      team = user.team
      self.auction = Auction.create(end_time: 3.days.from_now)
      player = Player.find_by(neo_id: params[:player_id])

      validations(player, team, league)
      raise "Can't create the auction" unless self.valid?
      
      make_rels(player, league)
      return auction
    rescue StandardError => e
      tx.failure
      Rails.logger.error e.message
      return false
    ensure
      tx.close()
    end
  end

  def valid?
    return errors.empty?
  end

 private

  def validations(player, team, league)
    check(player, "There is not such player")
    check(team.has_contract_with?(player), "You cant sell player that you don't own")
    check(team.league == league, "You cant sell players in other league")
    check(!league.has_auction?(player), "You cant sell the same player twice")
  end

  def check(condition, message)
    unless condition
      errors << message
    end
  end

  def make_rels(player, league)
    auction.player = player
    auction.league = league
  end
end
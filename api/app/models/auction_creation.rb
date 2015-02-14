class AuctionCreation

  def self.create(params, league, user)
    begin
      tx = Neo4j::Transaction.new
      team = user.team
      auction = Auction.create(end_time: 3.days.from_now)
      player = Player.find_by(neo_id: params[:player_id])
      raise "There is not such player" unless player
      raise "You cant sell player that you don't own" unless team.has_contract_with?(player)
      raise "You cant sell players in other league" unless team.league == league
      raise "You cant sell the same player twice" if league.has_auction?(player)
      auction.player = player
      auction.league = league
      return auction
    rescue StandardError => e
      tx.failure
      Rails.logger.error e.message
      return false
    ensure
      tx.close()
    end
  end


end
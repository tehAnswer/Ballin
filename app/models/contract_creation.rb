class ContractCreation

  def self.create(player, team, league, salary = 500000)
    begin
      tx = Neo4j::Transaction.new
      contract = Contract.create!(salary: salary)
      contract.team = team
      raise "#{player.name} has already a contract @ #{league.name} league." if league.players.include?(player)
      contract.player = player
      contract.league = league
    rescue StandardError => e
      tx.failure
      puts e
      return false
    ensure
      tx.close
    end
  end



end
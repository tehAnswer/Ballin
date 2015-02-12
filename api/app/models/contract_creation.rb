class ContractCreation

  def self.create(player, team, salary = 500000)
    begin
      tx = Neo4j::Transaction.new
      league = team.league
      raise "#{team.name} is not enrrolled in any league" if league.nil?
      contract = Contract.create!(salary: salary)
      contract.team = team
      raise "#{player.name} has already a contract @ #{league.name} league." if league.players.include?(player)
      contract.player = player
      contract.league = league
      return contract
    rescue StandardError => e
      tx.failure
      Rails.logger.error e.message
      return false
    ensure
      tx.close
    end
  end



end
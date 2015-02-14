class ContractCreation

  attr_accessor :errors, :contract

  def initilize
    self.errors = []
  end

  def create(player, team, salary = 500000)
    errors = []
    begin
      tx = Neo4j::Transaction.new
      league = team.league
      check_league(league)
      check_other_contract(league, player)
      self.contract = Contract.create(salary: salary)
      make_rels(team, player)
      return contract
    rescue StandardError => e
      tx.failure
      Rails.logger.error e.message
      return false
    ensure
      tx.close
    end
  end

 private

  def check_league(league)
    if league.nil?
      message = "#{team.name} is not enrrolled in any league" 
      errors << message
      raise message
    end
  end

  def check_other_contract(league, player)
    if league.players.include?(player)
      message = "#{player.name} has already a contract @ #{league.name} league." 
      errors << message
      raise message
    end
  end

  def make_rels(team, player)
    self.contract.team = team
    self.contract.player = player
    self.contract.league = team.league
  end



end
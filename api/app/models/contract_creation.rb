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
      check_player(player)
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

  def check_player(player)
    add_error "The player is null" if player.nil?
  end 

  def check_league(league)
    if league.nil?
      add_error "#{team.name} is not enrrolled in any league" 
    end
  end

  def check_other_contract(league, player)
    if league.players.include?(player)
      add_error "#{player.name} has already a contract @ #{league.name} league." 
    end
  end

  def make_rels(team, player)
    self.contract.team = team
    self.contract.player = player
    self.contract.league = team.league
  end

  def add_error(message)
    self.errors << message
    raise message
  end



end
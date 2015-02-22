class ContractCreation
  include AbstractTransaction
  attr_accessor :contract

  def initilize
    self.errors = []
  end

  def create(player, team, salary = 500000)
    errors = []
    transaction do
      check_if(team.nil?, "The team is null")
      league = team.league
      check_if(player.nil?, "The player is null")
      check_if(league.nil?, "#{team.name} is not enrrolled in any league")
      check_if(league.players.include?(player), "#{player.name} has already a contract @ #{league.name} league.")
      raise "Can't create the contract" unless self.valid?
      self.contract = Contract.create(salary: salary)
      make_rels(team, player)
      return contract
    end
  end

 private
  def make_rels(team, player)
    self.contract.team = team
    self.contract.player = player
    self.contract.league = team.league
  end



end
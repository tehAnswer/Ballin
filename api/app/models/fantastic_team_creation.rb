class FantasticTeamCreation

  attr_accessor :errors, :team

  def initialize
    self.errors = []
  end

  def create(division, team_data, user)
    errors = []
    begin
      tx = Neo4j::Transaction.new
      check_five_teams(division)
      create_team(team_data)
      make_rels(division, user)
      return team
    rescue StandardError => e
      tx.failure
      Rails.logger.error e.message
      return false
    ensure
      tx.close
    end
  end

  def valid?
    errors.empty?
  end

 private

  def make_rels(division, user)
    HasTeam.create(from_node: division, to_node: self.team)
    user.team = self.team
    set_up_default_contracts(division.league)
  end

  def create_team(team_data)
    self.team = FantasticTeam.create(team_data.except(:division_id))
    unless self.team.valid?
      team.errors.each do |key, message|
        self.errors << message
      end
      raise "Invalid team"
    end
  end

  def set_up_default_contracts(league)
    6.times { create_random_contract(league) }
  end

  def create_random_contract(league)
    loop do
      player = league.free_agents.sample
      debugger
      #contract = ContractCreation.create(player, team, 5_000_000)
      contract_creation = ContractCreation.new
      contract = contract_creation.create(player, team, 5_000_000)
      break contract if contract
    end
  end

  def check_five_teams(division)
    if division.number_of_teams == 5
      self.errors << "#{division.name} division of #{division.league.name} has already five teams." 
      raise "#{division.name} division of #{division.league.name} has already five teams."
    end
  end


end
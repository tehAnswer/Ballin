class FantasticTeamCreation
  include AbstractTransaction
  attr_accessor :team

  def create(division, team_data, user)
    transaction do
      check_if(division.number_of_teams == 5, "#{division.name} division of #{division.league.name} has already five teams.")
      create_team!(team_data)
      make_rels(division, user)
      return team
    end
  end

 private

  def make_rels(division, user)
    HasTeam.create(from_node: division, to_node: self.team)
    user.team = self.team
    set_up_default_contracts(division.league)
    team.rotation = Rotation.create!
  end

  def create_team!(team_data)
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
      contract_creation = ContractCreation.new
      contract = contract_creation.create(player, team, 5_000_000)
      debugger unless contract
      break contract if contract
    end
  end  
end
class TeamCreation

  def self.create(division, team_data)
    begin
      tx = Neo4j::Transaction.new
      raise "#{division.name} division of #{division.league.name} has already five teams." unless division.number_of_teams < 5
      team = FantasticTeam.create!(team_data)
      HasTeam.create(from_node: division, to_node: team)
      return team
    rescue StandardError => e
      Rails.logger.error e.message
      return false
    ensure
      tx.close
    end
  end


end
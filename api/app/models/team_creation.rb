class TeamCreation

  def self.create(division, team_data, user)
    begin
      tx = Neo4j::Transaction.new
      debugger
      raise "#{division.name} division of #{division.league.name} has already five teams." unless division.number_of_teams < 5
      team = FantasticTeam.new(team_data.except(:division_id))
      if team.valid?
        team.save!
        HasTeam.create(from_node: division, to_node: team)
        user.team = team
      end
      return team
    rescue StandardError => e
      tx.failure
      Rails.logger.error e.message
      return false
    ensure
      tx.close
    end
  end


end
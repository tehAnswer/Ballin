class TeamCreation

  def self.create(division, team_data)
    begin
      tx = Neo4j::Transaction.new
      slot = division.first_slot_free
      raise "#{division.name} division of #{division.league.name} has already five teams." unless slot
      team = FantasticTeam.create!(team_data)
      division[slot] = team
      return team
    rescue StandardError => e
      tx.failure
      puts e
      return false
    ensure
      tx.close
    end
  end


end
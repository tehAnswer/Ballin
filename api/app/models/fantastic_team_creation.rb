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
    #set_up_default_contracts(division.league)
    set_players(self.team, division.league)
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

  def set_players(team, league)
    params = { league_id: league.neo_id, team_id: team.neo_id }
    result = Neo4j::Session.current.query("
      MATCH (p:Player),(c:Contract),(l),(ft)
      where not (p)<-[:PLAYER]-(c)-[:LEAGUE]->(l) and id(l)={league_id} and id(ft)={team_id}
      with p,c,l,ft,rand() as _number
      order by _number limit 6
      create (p)<-[:PLAYER]-(cn:Contract {salary: 5000000})-[:LEAGUE]->(l), (ft)<-[:TEAM]-(cn)
      return id(p) as _id, count((p)<-[:PLAYER]-()-[:LEAGUE]->(l)) as number_contracts_league", params)
    player_ids = result.map { |player| player["_id"] if player["number_contracts_league"].to_i > 1}.compact
    return true if player_ids.empty?
    remove_duplicate_players(team, league, player_ids)
  end

  def remove_duplicate_players(team, league, player_ids)
    Neo4j::Session.current.query("
      MATCH (p:Player)<-[r1:PLAYER]-(c:Contract)-[r2:LEAGUE]->(l:League), (c)-[r3:TEAM]->(ft:FantasticTeam)
        where id(p) in #{player_ids} and id(l)= #{league.neo_id} and id(ft) = #{team.neo_id}
        delete r3, r2, r1, c")
  end
end
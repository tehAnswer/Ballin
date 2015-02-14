class Division 
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :out, :teams, model_class: FantasticTeam, rel_class: HasTeam
  has_one :in, :conference, model_class: Conference

  def team_ids
    teams.map { |team| team.neo_id }
  end

  def standings
    teams.sort_by { |team| team.score }
  end

  def number_of_teams
    teams.count.to_i
  end

  def conference_id
    conference.neo_id
  end

  def league
    conference.league
  end
end

class Division 
  include Neo4j::ActiveNode
  property :name, type: String

  has_one :out, :team_one, model_class: FantasticTeam
  has_one :out, :team_two, model_class: FantasticTeam
  has_one :out, :team_three, model_class: FantasticTeam
  has_one :out, :team_four, model_class: FantasticTeam
  has_one :out, :team_five, model_class: FantasticTeam

  #has_one :in, :conference, model_class: Conference, origin: :division_one || :division_two || :division_three

  def standings
    teams.sort_by { |team| team.score }
  end

  def teams_with_null_values
    [team_one, team_two, team_three, team_four, team_five]
  end

  def teams
    teams_with_null_values.select { |team| !team.nil? }
  end

  def first_slot_free
    teams_array = teams_with_null_values
    return false unless teams_array.any? { |x| x.nil? }
    number = teams_array.index(nil) + 1
    return "team_#{number.humanize}".to_sym
  end

  def number_of_teams
    teams.count { |x| !x.nil? }
  end

  def conference
     rel = rels(dir: :incoming).first
     return nil if rel.nil?
     rel.start_node
  end

  def conference_id
    conference.neo_id
  end
end

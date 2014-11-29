class Division 
  include Neo4j::ActiveNode
  property :name, type: String

  has_one :out, :team_one, model_class: FantasticTeam
  has_one :out, :team_two, model_class: FantasticTeam
  has_one :out, :team_three, model_class: FantasticTeam
  has_one :out, :team_four, model_class: FantasticTeam
  has_one :out, :team_five, model_class: FantasticTeam

  has_one :in, :conference, model_class: Conference,
   origin: :division_one || :division_two || :division_three

  def standings
    teams.sort_by(:score)
  end

  def teams
    [team_one, team_two, team_three, team_four, team_five]
  end

  def first_slot_free
    teams_array = teams
    return false unless teams_array.any? { |x| x.nil? }
    number = teams_array.index(nil) + 1
    #return "team_#{number.humanize}".to_sym
  end
end

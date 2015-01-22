class Division 
  include Neo4j::ActiveNode
  property :name, type: String

  #has_one :out, :team_one, model_class: FantasticTeam
  #has_one :out, :team_two, model_class: FantasticTeam
  #has_one :out, :team_three, model_class: FantasticTeam
  #has_one :out, :team_four, model_class: FantasticTeam
  #has_one :out, :team_five, model_class: FantasticTeam

  has_many :out, :teams, model_class: FantasticTeam
  has_one :in, :conference, model_class: Conference
  #has_one :in, :conference, model_class: Conference, origin: :division_one || :division_two || :division_three

  def standings
    teams.sort_by { |team| team.score }
  end

  def number_of_teams
    teams.count
  end

  def conference_id
    conference.neo_id
  end
end

class Conference 
  include Neo4j::ActiveNode
  property :name, type: String

  has_one :out, :division_one, model_class: Division
  has_one :out, :division_two, model_class: Division
  has_one :out, :division_three, model_class: Division
  has_one :in, :league, model_class: League, origin: :eastern_conference || :western_conference

  validates :name, presence: true


  def standings_per_division
    hash = Hash.new
    hash[division_one.name] = division_one.standings
    hash[division_two.name] = division_one.standings
    hash[division_three.name] = division_one.standings
    return hash
  end

  def number_of_teams
    division_one.number_of_teams + division_two.number_of_teams + division_three.number_of_teams
  end

  def division_ids
    [division_one.neo_id, division_two.neo_id, division_three.neo_id]
  end

end

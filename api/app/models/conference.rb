class Conference 
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :out, :divisions, model_class: Division
  has_one :in, :league, model_class: League, origin: :conferences

  #has_one :out, :division_one, model_class: Division
  #has_one :out, :division_two, model_class: Division
  #has_one :out, :division_three, model_class: Division
  #has_one :in, :league, model_class: League, origin: :eastern_conference || :western_conference

  validates :name, presence: true

  def standings_per_division
    hash = Hash.new
    divisions.each do |division|
      hash[division.name] = division.standings
    end
    return hash
  end

  def number_of_teams
    divisions.map{ |division| division.number_of_teams }.reduce(:+)
  end

  def division_ids
    divisions.map { |division| division.neo_id }
  end

end

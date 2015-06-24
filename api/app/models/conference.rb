class Conference 
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :out, :divisions, model_class: Division, type: 'DIVISIONS'
  has_one :in, :league, model_class: League, origin: :conferences

  validates :name, presence: true

  def standings_per_division
    hash = Hash.new
    divisions.each do |division|
      hash[division.name] = division.standings
    end
    return hash
  end

  def number_of_teams
    divisions.map { |division| division.number_of_teams }.reduce(:+)
  end

  def division_ids
    divisions.map { |division| division.neo_id }
  end

end

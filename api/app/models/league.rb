class League 
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :out, :conferences, model_class: Conference
  has_many :in, :contracts, model_class: Contract, origin: :league

  validates :name, presence: true
  validates :name, uniqueness: true

  def free_players
    Player.all - players
  end

  def players
    contracts.map { |c| c.player }
  end

  def filter_conferences(name)
    conferences.where(name: name).first
  end

  def western_conference
    self.filter_conferences('West')
  end

  def eastern_conference
    self.filter_conferences('East')
  end


  def western_standings
    western_conference.standings_per_division
  end

  def eastern_standings
    eastern_conference.standings_per_division
  end

  def number_of_teams
    conferences.map { |conference| conference.number_of_teams }.reduce(:+)
  end

  def conference_ids
    conferences.map { |conference| conference.neo_id }
  end


end

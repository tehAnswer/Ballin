class League 
  include Neo4j::ActiveNode
  property :name, type: String

  has_one :out, :eastern_conference, model_class: Conference
  has_one :out, :western_conference, model_class: Conference
  has_many :in, :contracts, model_class: Contract, origin: :league

  validates :name, presence: true
  validates :name, uniqueness: true

  def free_players
    Player.all - players
  end

  def players
    contracts.map { |c| c.player }
  end

  def western_standings
    western_conference.standings_per_division
  end

  def eastern_standings
    eastern_conference.standings_per_division
  end

  def number_of_teams
    eastern_conference.number_of_teams + western_conference.number_of_teams
  end

  def eastern_conference_id
    eastern_conference.neo_id
  end

  def western_conference_id
    western_conference.neo_id
  end


end

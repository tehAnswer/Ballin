class League 
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :out, :conferences, model_class: Conference, type: 'CONFERENCES'
  has_many :in, :contracts, model_class: Contract, origin: :league
  has_many :in, :auctions, model_class: Auction, origin: :league

  validates :name,  length: { minimum: 5, maximum: 23 }
  validates :name, presence: true
  validates :name, uniqueness: true

  def free_agents
    params = { league_id: self.neo_id }
    Neo4j::Session.current.query("
      MATCH (p:Player),(c:Contract),(l:League)
      where not (p)<-[:PLAYER]-(c)-[:LEAGUE]->(l) and id(l)={league_id}
      return distinct(p)", params)
  end

  def players
    contracts.player.to_a
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

  def auction_ids
    auctions.map { |auction| auction.neo_id }
  end

  def has_auction?(player)
    return auctions.player.where(neo_id: player.neo_id).count > 0
  end


end

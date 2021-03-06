class Player
  include Neo4j::ActiveNode

  property :name, type: String
  property :height_cm, type: Integer
  property :height_formatted, type: String
  property :weight_lb, type: Integer
  property :weight_kg, type: String
  property :position, type: String
  property :number, type: String, default: '-'
  property :birthplace, type: String
  property :birthdate, type: String
  property :updated_at
  property :created_at

  validates :name, :height_cm, :height_formatted,
    :height_cm, :birthdate, :birthplace, presence: true

  has_one :out, :real_team, model_class: NbaTeam, type: 'REAL_TEAM'
  has_many :out, :boxscores, model_class: BoxScore, type: 'BOXSCORES'
  has_many :in, :contracts, model_class: Contract, origin: :player
  has_many :in, :rotations, model_class: Rotation, rel_class: RosterSlot
  has_many :in, :auctions, model_class: Auction, origin: :player

  def stats
    return empty_hash if boxscores.count == 0
    hash = Neo4j::Session.current.query("MATCH (p:Player)-[:`BOXSCORES`]->(b:BoxScore) where id(p) = #{neo_id} 
      return sum(b.final_score) as final_score,
      count(b) as games_played,
      avg(b.minutes) as minutes,
      avg(b.points) as points,
      avg(b.assists) as assits, 
      avg(b.defr) as defr, 
      avg(b.ofr) as ofr, 
      avg(b.steals) as steals,
      avg(b.blocks) as blocks,
      avg(b.turnovers) as turnovers,
      avg(b.faults) as faults
      ").first.to_h
    
    Hash[hash.map { |key, value| [key, value.round(2)] }]
  end

  def nba_team_id
    real_team.nil? ? -1 : real_team.neo_id
  end

  def fantastic_teams
    contracts.collect { |contract| contract.team }
  end

  def box_score_ids
    boxscores.map { |boxscore| boxscore.neo_id }
  end

  private 
    def empty_hash
      {
        final_score: 0,
        games_played: 0,
        points: 0,
        assits: 0,
        defr: 0,
        ofr: 0,
        steals: 0,
        blocks: 0,
        turnovers: 0,
        faults: 0
      }
    end
end

class NbaTeam 
  include Neo4j::ActiveNode
  property :team_id, type: String
  property :abbreviation, type: String
  property :name, type: String
  property :conference, type: String
  property :division, type: String
  property :site_name, type: String
  property :city, type: String
  property :state, type: String

  validates :team_id, :abbreviation, :name, :conference, :site_name, :city, :state, 
    presence: true
  validates :team_id, uniqueness: true

  has_many :in, :players, model_class: Player, origin: :real_team
  has_many :in, :away_games, model_class: Game, origin: :away_team
  has_many :in, :home_games, model_class: Game, origin: :home_team


  def away_game_ids
    away_games.map { |x| x.neo_id }
  end

  def home_game_ids
    home_games.map { |x| x.neo_id }
  end

  def player_ids
    players.map { |x| x.neo_id }
  end

  def next_gameid
   Neo4j::Session.current.query("MATCH (g:Game)-[r]-(t:NbaTeam) where g.status = \"scheduled\" and ID(t) = #{neo_id} 
    return ID(g) order by g.date_formatted limit 1").first["ID(g)"]
  end

end

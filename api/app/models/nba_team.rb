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


end
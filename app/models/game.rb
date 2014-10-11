class Game 
  include Neo4j::ActiveNode

  STATUS = ['Completed', 'Cancelled']
  property :game_id, type: String
  property :season_type, type: String
  property :status, type: String
  property :start_date_time, type: String
  property :away_score, type: Integer, default: 0
  property :home_score, type: Integer, default: 0

  validates :game_id, :season_type, :status, :start_date_time, presence: true
  validates :game_id, uniqueness: true
  validates :status, inclusion: STATUS

  has_one :out, :away_team, model_class: NbaTeam
  has_one :out, :home_team, model_class: NbaTeam
  has_many :out, :away_boxscores, model_class: BoxScore
  has_many :out, :home_boxscores, model_class: BoxScore


end

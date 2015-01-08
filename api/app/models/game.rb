class Game 
  include Neo4j::ActiveNode

  property :game_id, type: String
  property :season_type, type: String
  property :status, type: String
  property :start_date_time, type: String
  property :date_formatted, type: String
  property :away_score, type: Integer, default: 0
  property :home_score, type: Integer, default: 0

  validates :game_id, :season_type, :status, :start_date_time, :date_formatted, presence: true
  validates :game_id, uniqueness: true

  has_one :out, :away_team, model_class: NbaTeam
  has_one :out, :home_team, model_class: NbaTeam

  has_many :out, :boxscores, model_class: BoxScore


  def self.yesterday
    on_date 1.day.ago
  end

  def self.on_date(day)
    Game.where(date_formatted: day.strftime('%Y%m%d'))
  end

  def home_boxscores
    filtered_score('home')
  end
   
  def away_boxscores
    filtered_score('away')
  end
   
  private

  def filtered_score(side)
    self.boxscores.where(type: side)
  end

end

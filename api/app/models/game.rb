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
  validate :check_start_date_time_and_date_formatted_matches

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

  def check_start_date_time_and_date_formatted_matches
    errors.add(:date_formatted, "date_formatted don't match with start_date_time") unless start_date_time.to_datetime.strftime('%Y%m%d') == date_formatted
  end

  def home_boxscore_ids
    home_boxscores.map { |boxscore| boxscore.neo_id }
  end

  def away_boxscore_ids
    away_boxscores.map { |boxscore| boxscore.neo_id }
  end

  def away_team_id
    away_team.nil? ? -1 : away_team.neo_id
  end

  def home_team_id
    home_team.nil? ? -1 : home_team.neo_id
  end

  def date_time
    start_date_time.to_datetime.strftime('%a %B %d, %H:%M')
  end

 private
  def filtered_score(side)
    boxscores.where(side: side)
  end

end

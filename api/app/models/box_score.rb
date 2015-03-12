class BoxScore 
  include Neo4j::ActiveNode
  include BoxScoreHelper

  property :minutes, type: Integer, default: 0
  property :points, type: Integer, default: 0
  property :assists, type: Integer, default: 0
  property :steals, type: Integer, default: 0
  property :defr, type: Integer, default: 0
  property :ofr, type: Integer, default: 0
  property :blocks, type: Integer, default: 0
  property :fta, type: Integer, default: 0
  property :ftm, type: Integer, default: 0
  property :fga, type: Integer, default: 0
  property :fgm, type: Integer, default: 0
  property :lsa, type: Integer, default: 0
  property :lsm, type: Integer, default: 0
  property :turnovers, type: Integer, default: 0
  property :final_score, type: Float, default: 0
  property :is_starter, type: Boolean, default: false
  property :is_local, type: Boolean, default: false
  property :faults, type: Integer, default: 0

  validates :minutes, :points, :assists, :steals, :defr, :ofr, :blocks,
    :fta, :ftm, :fga, :fgm, :lsa, :lsm, :final_score, :faults, presence: true
  validates :fta, numericality: { greater_than_or_equal_to: :ftm  }
  validates :fga, numericality: { greater_than_or_equal_to: :fgm }
  validates :lsa, numericality: { greater_than_or_equal_to: :lsm }
  validates :points, numericality: { equal_to: :points_made }

  has_one :in, :game, model_class: Game, origin: :boxscores
  has_one :in, :player, model_class: Player, origin: :boxscores

  before_create do
    self.final_score = _final_score
  end

 
  def points_made
    ftm + 2 * (fgm - lsm) + 3 * lsm
  end


  def player_id
    player.nil? ? -1 : player.neo_id
  end

  def game_id
    game.nil? ? -1 : game.neo_id
  end

  def team
    is_local ? game.home_team : game.away_team
  end



end

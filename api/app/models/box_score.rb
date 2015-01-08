class BoxScore 
  include Neo4j::ActiveNode

  property :side
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
    self.final_score = puntuation_calculator
  end

 
  def points_made
    ftm + 2 * (fgm - lsm) + 3 * lsm
  end

  def puntuation_calculator
    bonus = points + 1.25 * assists + 1.25 * defr + 1.5 * ofr 
      + 2.5 * steals + 2 * blocks
    penalty = (fta - ftm)/10 + (fga - lsa - fgm)/5 + (lsa - lsm)/3 + 3 * turnovers
    (bonus - penalty).round(2)
  end

  def home?
    self.side == 'home'
  end
   
  def away?
    self.side == 'away'
  end

  def player_id
    player.neo_id
  end

  def game_id
    game.neo_id
  end



end

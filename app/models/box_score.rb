class BoxScore 
  include Neo4j::ActiveNode

  property :minutes, type: Integer, default: 0
  property :points, type: Integer, default: 0
  property :assists, type: Integer, default: 0
  property :steals, type: Integer, default: 0
  property :defr, type: Integer, default: 0
  property :ofr, type: Integer, default: 0
  property :blocks, type: Integer, default: 0
  property :fta, type: Integer, default: 0
  property :ftm, type: Integer, default: 0
  property :msa, type: Integer, default: 0
  property :msm, type: Integer, default: 0
  property :lsa, type: Integer, default: 0
  property :lsm, type: Integer, default: 0
  property :turnovers, type: Integer, default: 0
  property :final_score, type: Float, default: 0
  property :is_started, type: Boolean
  property :faults, type: Integer, default: 0

  validates :minutes, :points, :assists, :steals, :defr, :ofr, :blocks,
    :fta, :ftm, :msa, :msm, :lsa, :lsm, :final_score, :is_started, :faults, presence: true
  validates :fta, numericality: { greater_than_or_equal_to: :ftm  }
  validates :msa, numericality: { greater_than_or_equal_to: :msm }
  validates :lsa, numericality: { greater_than_or_equal_to: :lsm }
  validates :points, numericality: { equal_to: :points_made }

  has_one :in, :game, model_class: Game, 
    origin: :home_boxscores || :away_boxscore
  has_one :out, :player, model_class: Player

 
  def points_made
    ftm + 2 * msm + 3 * lsm
  end

  def points_calculator
    bonus = points + 1.25 * assists + 1.25 * defr + 1.5 * ofr 
      + 2.5 * steals + 2 * blocks
    penalty = (fta - ftm)/10 + (msa - msm)/5 + (lsa - lsm)/3 + 3 * turnovers
    (bonus - penalty).round(2)
  end


end

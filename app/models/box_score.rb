class BoxScore 
  include Neo4j::ActiveNode

  property :play_time, type: String, default: '00:00'
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

  validates :play_time, :points, :assists, :steals, :defr, :ofr, :blocks,
    :fta, :ftm, :msa, :msm, :lsa, :lsm, :final_score, presence: true
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


end

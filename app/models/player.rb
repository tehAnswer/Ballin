class Player 
  include Neo4j::ActiveNode

  POSITIONS = ['PG', 'SG', 'SF', 'PF', 'C']

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

  #validates :position, inclusion: POSITIONS
  validates :name, :height_cm, :height_formatted,
    :height_cm, :birthdate, :birthplace, presence: true

  has_one :out, :real_team, model_class: NbaTeam
  has_many :in, :boxscores, model_class: BoxScore, origin: :player
  has_many :out, :contracts, model_class: Contract

end

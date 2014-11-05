class FantasticTeam 
  include Neo4j::ActiveNode
  property :name, type: String
  property :abbreviation, type: String
  property :hood, type: String
  property :headline, type: String
  property :score, type: Float, default: 0

  validates :name, :abbreviation, uniqueness: true
  validates :name, :abbreviation, :hood, presence: true
  
  has_one :in, :division, model_class: Division,
    origin: :team_one || :team_two || :team_three || :team_four || :team_five
  has_many :in, :contracts, model_class: Contract, origin: :team
  
  has_one :out, :rotation, model_class: Rotation
  has_one :in, :user, model_class: User, origin: :team
  
end

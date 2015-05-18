class FantasticTeam 
  include Neo4j::ActiveNode
  property :name, type: String
  property :abbreviation, type: String
  property :hood, type: String
  property :headline, type: String
  property :score, type: Float, default: 0
  property :budget, type: Float, default: 0

  validates :name, :abbreviation, uniqueness: true
  validates :name, :abbreviation, :hood, presence: true
  validates :name,  length: { maximum: 23 }
  validates :abbreviation, length: { maximum: 4 }
  validates :headline, length: { maximum: 60 }
  
  has_one :in, :division, model_class: Division, rel_class: HasTeam
  has_many :in, :contracts, model_class: Contract, origin: :team
  has_many :in, :bids, model_class: Bid, origin: :team
  
  has_one :out, :rotation, model_class: Rotation
  has_one :in, :user, model_class: User, origin: :team

  def conference
    division.conference
  end

  def league
    conference.league
  end

  def user_id
    user.nil? ? -1 : user.neo_id
  end

  def players
    contracts.player
  end

  def has_contract_with?(player)
    return players.where(neo_id: player.neo_id).count > 0
  end

  def contract_ids
    contracts.map { |c| c.neo_id }
  end

  def rotation_id
    rotation.nil? ? -1 : rotation.neo_id
  end

  def division_id
    division.nil? ? -1 : division.neo_id
  end
  
end

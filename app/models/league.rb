class League 
  include Neo4j::ActiveNode
  property :name, type: String
  property :password, type: String

  has_one :out, :eastern_conference, model_class: Conference
  has_one :out, :western_conference, model_class: Conference
  has_many :in, :contracts, model_class: Contract, origin: :league

  validates :name, presence: true
  validates :name, uniqueness: true

  def free_players
    Player.all - contracts.map { |c| c.player }
  end

end

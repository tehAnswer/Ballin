class League 
  include Neo4j::ActiveNode
  property :name, type: String
  property :password, type: String

  has_one :out, :eastern_conference, model_class: Conference
  has_one :out, :western_conference, model_class: Conference
  has_many :out, :contracts, model_class: Contract

  validates :name, presence: true
  validates :name, uniqueness: true

end

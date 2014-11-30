class Conference 
  include Neo4j::ActiveNode
  property :name, type: String

  has_one :out, :division_one, model_class: Division
  has_one :out, :division_two, model_class: Division
  has_one :out, :division_three, model_class: Division
  has_one :in, :league, model_class: League, origin: :eastern_conference || :western_conference

  validates :name, presence: true

end

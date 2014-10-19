class Contract 
  include Neo4j::ActiveNode
  property :salary, type: Integer

  has_one :in, :league, model_class: League, origin: :contracts
  has_one :in, :team, model_class: FantasticTeam, origin: :contracts
  has_one :in, :player, model_class: Player, origin: :contracts

end

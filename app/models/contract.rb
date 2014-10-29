class Contract 
  include Neo4j::ActiveNode
  property :salary, type: Integer

  has_one :out, :league, model_class: League
  has_one :out, :team, model_class: FantasticTeam
  has_one :out, :player, model_class: Player

end

class Contract 
  include Neo4j::ActiveNode
  property :salary, type: Integer

  has_one :out, :league, model_class: League
  has_one :out, :team, model_class: FantasticTeam
  has_one :out, :player, model_class: Player

  validates :salary, numericality: { greater_than_or_equal_to: 1000 }

  def league_id
    league.neo_id
  end

  def team_id
    team.neo_id
  end

  def player_id
    player.neo_id
  end

end

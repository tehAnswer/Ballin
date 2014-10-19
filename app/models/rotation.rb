class Rotation 
  include Neo4j::ActiveNode

  has_one :out, :center, model_class: Player, rel_class: CenterSlot
  has_one :out, :power_forward, model_class: Player, rel_class: PowerForwardSlot
  has_one :out, :forward, model_class: Player, rel_class: ForwardSlot
  has_one :out, :shooting_guard, model_class: Player, rel_class: ShootingGuardSlot
  has_one :out, :point_guard, model_class: Player, rel_class: PointGuardGuardSlot
  has_one :out, :sixth_man, model_class: Player, rel_class: SixthManSlot

  has_one :in, :team, model_class: FantasticTeam, origin: :rotation

  def players
    [center, power_forward, forward, shooting_guard, point_guard, sixth_man]
  end
end

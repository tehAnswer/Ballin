class Rotation 
  include Neo4j::ActiveNode

  has_one :out, :center, model_class: Player, rel_class: CenterSlot
  has_one :out, :power_forward, model_class: Player, rel_class: PowerForwardSlot
  has_one :out, :small_forward, model_class: Player, rel_class: SmallForwardSlot
  has_one :out, :shooting_guard, model_class: Player, rel_class: ShootingGuardSlot
  has_one :out, :point_guard, model_class: Player, rel_class: PointGuardSlot
  has_one :out, :sixth_man, model_class: Player, rel_class: RosterSlot

  has_one :in, :team, model_class: FantasticTeam, origin: :rotation

  def players
    [center, power_forward, small_forward, shooting_guard, point_guard, sixth_man]
  end

  def playersId
   {
    :C => center_id,
    :PF => power_forward_id,
    :SF => small_forward_id,
    :SG => shooting_guard_id,
    :PG => point_guard_id
   } 
  end

  def center_id
    center.nil? ? -1 : center.neo_id
  end

  def power_forward_id
    power_forward.nil? ? -1 : power_forward.neo_id
  end

  def small_forward_id
    small_forward.nil? ? -1 : small_forward.neo_id
  end

  def shooting_guard_id
    shooting_guard.nil? ? -1 : shooting_guard.neo_id
  end

  def point_guard_id
    point_guard.nil? ? -1 : point_guard.neo_id
  end 
end

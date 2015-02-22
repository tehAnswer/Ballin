class PointGuardSlot < RosterSlot
  type 'POINT_GUARD'
  validate :is_point_guard
  from_class Rotation
  to_class Player

  def is_point_guard
    can_play('PG', 'G')
  end
end
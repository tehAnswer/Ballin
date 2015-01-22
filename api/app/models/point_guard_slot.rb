class PointGuardSlot < RosterSlot
  type 'POINT_GUARD'
  validate :is_point_guard

  def is_point_guard
    can_play('PG', 'G')
  end
end
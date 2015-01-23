class PointGuardSlot < RosterSlot
  type '#point_guard'
  validate :is_point_guard

  def is_point_guard
    can_play('PG', 'G')
  end
end
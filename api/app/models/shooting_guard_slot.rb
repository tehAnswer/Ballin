class ShootingGuardSlot < RosterSlot
  type 'SHOOTING_GUARD'
  validate :is_shooting_guard
  from_class Rotation
  to_class Player

  def is_shooting_guard
    can_play('SG', 'G')
  end
end
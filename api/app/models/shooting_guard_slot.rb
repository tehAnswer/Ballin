class ShootingGuardSlot < RosterSlot
  type 'SHOOTING_GUARD'
  validate :is_shooting_guard

  def is_shooting_guard
    can_play('SG', 'G')
  end
end
class ShootingGuardSlot < RosterSlot
  type '#shooting_guard'
  validate :is_shooting_guard

  def is_shooting_guard
    can_play('SG', 'G')
  end
end
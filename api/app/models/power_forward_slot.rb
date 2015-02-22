class PowerForwardSlot < RosterSlot
  type 'POWER_FORWARD'
  validate :is_forward
  from_class Rotation
  to_class Player

  def is_forward
    can_play('PF', 'F')
  end
end
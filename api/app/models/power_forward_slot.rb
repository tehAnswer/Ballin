class PowerForwardSlot < RosterSlot
  type 'POWER_FORWARD'
  validate :is_forward

  def is_forward
    can_play('PF', 'F')
  end
end
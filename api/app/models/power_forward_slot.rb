class PowerForwardSlot < RosterSlot
  type '#power_forward'
  validate :is_forward

  def is_forward
    can_play('PF', 'F')
  end
end
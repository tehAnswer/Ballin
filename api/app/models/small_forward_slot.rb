class SmallForwardSlot < RosterSlot
  type '#small_forward'
  validate :is_forward

  def is_foward
    can_play('SF', 'F')
  end
end
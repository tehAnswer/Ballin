class SmallForwardSlot < RosterSlot
  type 'SMALL_FORWARD'
  validate :is_forward

  def is_foward
    can_play('SF', 'F')
  end
end
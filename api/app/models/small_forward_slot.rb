class SmallForwardSlot < RosterSlot
  type 'SMALL_FORWARD'
  validate :is_forward
  from_class Rotation
  to_class Player

  def is_forward
    can_play('SF', 'F')
  end
end
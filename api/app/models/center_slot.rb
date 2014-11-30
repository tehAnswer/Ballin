class CenterSlot < RosterSlot
  type '#center'
  validate :is_center

  def is_center
    can_play('C')
  end
end
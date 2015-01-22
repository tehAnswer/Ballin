class CenterSlot < RosterSlot
	type 'CENTER'
  validate :is_center

  def is_center
    can_play('C')
  end
end
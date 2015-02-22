class CenterSlot < RosterSlot
	type 'CENTER'
  validate :is_center
  from_class Rotation
  to_class Player

  def is_center
    can_play('C')
  end
end
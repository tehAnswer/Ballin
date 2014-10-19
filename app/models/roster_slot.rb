class RosterSlot
  include Neo4j::ActiveRel
  from_class FantasticTeam
  to_class Player

  validate :has_contract, :is_not_selected

  private

  def has_contract
    self.errors.add(:has_contract, "#{to_node.name} has not contract with #{from_node.name}")
      unless from_node.players.include?(to_node)
  end

  def is_not_selected
    self.errors.add(:is_not_selected, "#{to_node.name} has been already selected") 
      unless from_node.rotation.players.include?(to_node)
  end

  def can_play(main_position, second_position = '')
    self.errors.add(:position, "#{to_node.name} ain't a #{main_position}") 
      unless from_node.position == main_position || from_node.position == second_position
  end

end

class CenterSlot < RosterSlot
  type '#center'
  validate :is_center

  def is_center
    can_play('C')
  end
end

class PowerForwardSlot < RosterSlot
  type '#power_forward'
  validate :is_forward

  def is_forward
    can_play('PF', 'F')
  end
end

class SmallForwardSlot < RosterSlot
  type '#small_forward'
  validate :is_forward

  def is_foward
    can_play('SF', 'F')
  end
end

class ShootingGuardSlot < RosterSlot
  type '#shooting_guard'
  validate :is_shooting_guard

  def is_shooting_guard
    can_play('SG', 'G')
  end
end

class PointGuardSlot < RosterSlot
  type '#point_guard'
  validate :is_point_guard

  def is_point_guard
    can_play('PG', 'G')
  end
end

class RosterSlot
  include Neo4j::ActiveRel
  from_class Rotation
  to_class Player
  validate :has_contract, :has_been_already_selected

  
  def has_contract
    self.errors.add(:has_contract, "#{to_node.name} has not contract with #{from_node.team.name}") unless from_node.team.players.include?(to_node)
  end

  def has_been_already_selected
    self.errors.add(:has_been_already_selected, "#{to_node.name} has been already selected") if from_node.players.select { |player| player == to_node }.count > 1
  end

  def can_play(main_position, second_position = '')
    self.errors.add(:position, "#{to_node.name} ain't a #{main_position}") unless to_node.position == main_position || to_node.position == second_position
  end

end
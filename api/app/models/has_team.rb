class HasTeam
  include Neo4j::ActiveRel
  from_class Division
  to_class FantasticTeam

  validate :free_space

  def free_space
  	self.errors.add(:free_space, "Division #{from_node.neo_id} has not free space") unless from_node.teams.count < 5
  end
end
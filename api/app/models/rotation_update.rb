class RotationUpdate
  include AbstractTransaction
  attr_accessor :rotation

  def initialize(rotation)
    self.rotation = rotation
    super()
  end

  def update(params)
    transaction do
      check_if(rotation.nil?, "Rotation is null.")
      make_rels(rotation, params)
      raise "Invalid rotation" unless self.valid?
      return rotation
    end
  end


  def make_rels(rotation, params)
    params.each do |key, value|
      klass_rel = get_class_rel(key)
      check_if(klass_rel.nil?, "There is not such position")
      rotation.rels.each { |x| x.destroy if (x.class == klass_rel || x.end_node.neo_id == value )}
      player = Player.find_by(neo_id: value)
      rel = klass_rel.create(from_node: rotation, to_node: player)

      add_errors_from(rel) unless rel.valid?
    end
  end

  def get_class_rel(key)
    return CenterSlot if key == "C"
    return PowerForwardSlot if key == "PF"
    return SmallForwardSlot if key == "SF"
    return ShootingGuardSlot if key == "SG"
    return PointGuardSlot if key == "PG"
    return RosterSlot if key == "SXTH"
    return nil
  end

  def add_errors_from(rel)
    rel.errors.each do |key, message|
      errors << message
    end
  end
end
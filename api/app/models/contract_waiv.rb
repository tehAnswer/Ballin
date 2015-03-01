class ContractWaiv
  include AbstractTransaction
  attr_accessor :contract

  def initialize(contract)
    self.contract = contract
  end


  def waiv
    transaction do
      check_if(contract.nil?, "Contract is null")
      destroy_rels
      return true
    end
  end

 private

  def destroy_rels
    player = contract.player
    rotation = contract.team.rotation
    destroy_rotation_rels(rotation, player) if rotation.players.include?(player)
    contract.player = nil
    contract.league = nil
    contract.team = nil
    contract.destroy
  end

  def destroy_rotation_rels(rotation, player)
    position = rotation.position_of(player)
    rotation.send(position+"=", nil)
  end



end
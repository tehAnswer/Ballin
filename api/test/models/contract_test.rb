require 'test_helper'

class ContractTest < ActiveSupport::TestCase
  test "minimum salary" do
    # This in China or Spain may not pass.
    contract = Contract.create(salary: 1)
    assert_equal false, contract.valid?
    contract.salary = 500_000
    assert_equal true, contract.valid?
  end

  test "contract creation" do
    creation = ContractCreation.new
    team = FantasticTeam.find_by(name: "TeamWithUser")
    player = Player.create(name: 'Kobez',
      height_cm: 200,
      height_formatted: "6'1\"",
      weight_lb: 100,
      weight_kg: 50,
      position: 'SG',
      number: '24',
      birthplace: 'Philly',
      birthdate: Date.new
      )
    contract = creation.create(player, team)
    assert_not_equal false, contract
    assert_equal player, contract.player
    assert_equal team.league, contract.league
  end
end

require 'test_helper'

class RotationsTest < ActionDispatch::IntegrationTest
  test "send a correct lineup" do
    user = User.find_by(username: "UserWithTeam")
    token = user.auth_code
    rotation = user.team.rotation

    lineup = {
      C: Player.find_by(name: "Shaq").neo_id,
      PF: Player.find_by(name:"Joel Embiid").neo_id,
      SF: Player.find_by(name: "Kevin Durant").neo_id,
      SG: Player.find_by(name: "Kobe Bryant").neo_id,
      PG: Player.find_by(name:"Allen Iverson").neo_id
    }

    
    put "/api/rotations/#{rotation.neo_id}", { rotation: lineup, debug: true }, { dagger: token }
    assert_equal 204, response.status
    get "/api/rotations/#{rotation.neo_id}", { }, { dagger: token }
    assert_equal 200, response.status
    token = User.find_by(username: "Eric Cartman").auth_code
    get "/api/rotations/#{rotation.neo_id}", { }, { dagger: token }   
    assert_equal 403, response.status
  end

  test "incorrect lineup" do
    user = User.find_by(username: "UserWithTeam")
    token = user.auth_code
    rotation = user.team.rotation

    lineup = {
      C: Player.find_by(name:"Allen Iverson").neo_id,
      PF: Player.find_by(name:"Joel Embiid").neo_id,
      SF: Player.find_by(name: "Kevin Durant").neo_id,
      SG: Player.find_by(name: "Kobe Bryant").neo_id,
      PG: Player.find_by(name: "Shaq").neo_id
    }

    put "/api/rotations/#{rotation.neo_id}", { rotation: lineup }, { dagger: token }
    assert_equal 422, response.status
    put "/api/rotations/#{rotation.neo_id}", { }, { dagger: token }
    assert_equal 422, response.status
  end

  test "waive player" do
    eric = User.find_by(username: "Eric Cartman")
    contract = Contract.first
    user = contract.team.user
    contract_id = contract.neo_id
    player_id = contract.player_id

    delete "/api/contracts/#{contract_id}", { }, { dagger: eric.auth_code }
    assert_equal 403, response.status 
    delete "/api/contracts/#{contract.neo_id}", { }, { dagger: user.auth_code }
    assert_equal 200, response.status
    assert_equal false, user.team.contract_ids.include?(contract_id)
    assert_equal false, user.team.rotation.playersId.include?(player_id)
  end

end
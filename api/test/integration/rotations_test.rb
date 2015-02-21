require 'test_helper'

class RotationsTest < ActionDispatch::IntegrationTest
  test "send a correct lineup" do
    token = User.find_by(username: "UserWithTeam").auth_code
    lineup = {
      C: Player.find_by(name: "Shaq").neo_id,
      PF: Player.find_by(name:"Joel Embiid").neo_id,
      SF: Player.find_by(name: "Kevin Durant").neo_id,
      SG: Player.find_by(name: "Kobe Brayant").neo_id,
      G: Player.find_by(name:"Allen Iverson").neo_id
    }

    post "/api/rotations", { rotation: lineup }, { dagger: token }
    assert_equal 200, response.status
    hash = json(response)[:rotation]
    get "/api/rotations/#{hash[:neo_id]}", { }, { dagger: token }
    assert_equal 200, response.status
    token = User.find_by(username: "UserWithoutTeam").auth_code
    get "/api/rotations/#{hash[:neo_id]}", { }, { dagger: token }   
    assert_equal 403, response.status
  end

  test "incorrect lineup" do
    token = User.find_by(username: "UserWithTeam").auth_code
    lineup = {
      C: Player.find_by(name:"Allen Iverson").neo_id,
      PF: Player.find_by(name:"Joel Embiid").neo_id,
      SF: Player.find_by(name: "Kevin Durant").neo_id,
      SG: Player.find_by(name: "Kobe Brayant").neo_id,
      G: Player.find_by(name: "Shaq").neo_id
    }

    post "/api/rotations", { rotation: lineup }, { dagger: token }
    assert_equal 422, response.status
    post "/api/rotations", { }, { dagger: token }
    assert_equal 422, response.status
  end

end
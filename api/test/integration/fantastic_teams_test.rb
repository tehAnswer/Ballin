require 'test_helper'

class FantasticTeamsTest < ActionDispatch::IntegrationTest
  test "get all fantastic teams" do
    token = User.first.auth_code
    get 'api/fantastic_teams', { }, { dagger: token }
    assert_equal 200, response.status
    hash = parse(response.body)
    assert_equal 0, hash[:fantastic_teams].count

    get 'api/fantastic_teams', { }, { }
    assert_equal 401, response.status
  end

  test "get one fantastic team" do
    token = User.first.auth_code
    ft = FantasticTeam.first

    get "api/fantastic_teams/#{ft.neo_id}", { }, { dagger: token }
    assert_equal 200, response.status
    hash = parse(response.body)
    assert_equal ft.name, hash[:fantastic_team][:name]
    assert_equal ft.neo_id, hash[:fantastic_team][:neo_id]

    get "api/fantastic_teams/#{ft.neo_id}", { }, { }
    assert_equal 401, response.status
  end

  test "create a fantastic team" do
    user = User.find_by(username: "Second")
    ft = {
      fantastic_team: {
        name: "America",
        abbreviation: "AME",
        hood: "Mexico",
        headline: "Andale, andale.",
        division_id: Division.first.neo_id
      }
    }

    post "api/fantastic_teams", ft, { dagger: user.auth_code }
    assert_equal 201, response.status
    hash = parse(response.body)
    assert_equal ft[:fantastic_team][:name], hash[:fantastic_team][:name]
    assert_equal user.neo_id, hash[:fantastic_team][:user_id]


    post "api/fantastic_teams", ft, { dagger: User.first.auth_code }
    assert_equal 422, response.status

    # Change name and abbreviation to make the ft unique
    ft[:fantastic_team][:name] = "Fasfafsfafsfafs"
    ft[:fantastic_team][:abbreviation] = "Fasfas"
    post "api/fantastic_teams", ft, { dagger: user.auth_code }
    assert_equal 422, response.status
  end

end
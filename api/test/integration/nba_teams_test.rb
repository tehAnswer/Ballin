class NbaTeamsTest < ActionDispatch::IntegrationTest
  test "get one team" do
    auth_code = User.first.auth_code
    nba_team = NbaTeam.first

    get "/api/nba_teams/#{nba_team.neo_id}", { }, { dagger: auth_code }
    assert_equal 200, response.status

    get "/api/nba_teams/#{nba_team.neo_id}", { }, { }
    assert_equal 401, response.status

    get "/api/nba_teams/1221343432", { }, { dagger: auth_code }
    assert_equal 404, response.status
  end

  test "get multiple teams" do
    auth_code = User.first.auth_code
    nba_team1 = NbaTeam.first
    nba_team2 = NbaTeam.last

    get "/api/nba_teams", { ids: [nba_team1.neo_id, nba_team2.neo_id] }, { dagger: auth_code }
    hash = parse(response.body)
    assert_equal 200, response.status
    assert_equal 2, hash[:nba_teams].count
  end
end
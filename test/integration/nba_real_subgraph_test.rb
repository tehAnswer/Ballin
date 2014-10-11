require 'test_helper'

class NbaRealSubgraphTest < ActionDispatch::IntegrationTest

  test 'example of subgraph' do
    teams = add_teams
    players = add_players


    players[0].real_team = teams[1]
    players[1].real_team = teams[0]

    game = Game.create!({
      game_id: 'abc',
      status: 'Completed',
      season_type: 'Regular',
      start_date_time: Date.new
      })
    boxscore_kobe = BoxScore.create!({
      points: 30,
      assists: 10
      })
    boxscore_ai = BoxScore.create!({
      points: 90,
      ofr: 12
      })

    boxscore_kobe.player = players[0]
    boxscore_ai.player = players[1]
    game.away_boxscores << boxscore_kobe
    game.home_boxscores << boxscore_ai
    game.away_team = teams[1]
    game.home_team = teams[0]

    assert 2, game.home_boxscores.size




  end

end
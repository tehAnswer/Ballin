require 'test_helper'

class MisplacedPlayersTest < ActionDispatch::IntegrationTest
    test 'misplaced players' do
    ft = FantasticTeam.new({
      name: 'Dream Team',
      abbreviation: 'DRM',
      hood: 'Piedras Blancas'
      })

    assert_equal true, ft.save

    center = Player.where(position: 'C').first
    point_guard = Player.where(position: 'PG').first

    ft.center = point_guard
    ft.point_guard = center

  end
end
require 'test_helper'

class FantasticTeamTest < ActiveSupport::TestCase
  test 'missing data' do
    team = FantasticTeam.new
    assert_equal false, team.valid?
    team.name = 'One name'
    assert_equal false, team.valid?
    team.abbreviation = 'DE'
    assert_equal false, team.valid?
    team.hood = 'Piedras Blancas'
    assert_equal true, team.valid?
  end
end

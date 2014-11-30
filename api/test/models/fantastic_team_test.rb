require 'test_helper'

class FantasticTeamTest < ActiveSupport::TestCase
  test 'missing data' do
    team = FantasticTeam.new
    assert_equal false, team.valid?
    team.name = 'Does not exit in my graph'
    team.abbreviation = 'DE'
    team.hood= 'Piedras Blancas'
    assert_equal true, team.valid?
  end
end

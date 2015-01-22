require 'test_helper'

class NbaTeamTest < ActiveSupport::TestCase
  test 'missing data' do
     team = NbaTeam.new({name: 'Philadelphia 76ers' })

     team.abbreviation = 'PHI'
     team.team_id ='76ers'
     team.conference = 'East'
     team.division = 'Atlantic'
     team.site_name = 'Wells Fargo'
     team.city = 'Philadelphia'
     team.state = 'Pensylvannia'

     assert_equal true, team.valid?
  end
end

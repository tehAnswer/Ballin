require 'test_helper'

class DivisionTest < ActiveSupport::TestCase
  test "division has not more than five teams" do
     division = Division.create!({name: "Drake - Headlines" })
     assert_equal 0, division.teams.count

     team_one = FantasticTeam.create!({ name: 'AA', abbreviation: 'AA', hood:'AA'})
     team_two = FantasticTeam.create!({ name: 'BB', abbreviation: 'BB', hood:'bb'})
     team_three = FantasticTeam.create!({ name: 'CC', abbreviation: 'CC', hood:'CC'})
     team_four = FantasticTeam.create!({ name: 'DD', abbreviation: 'DD', hood:'DD'})
     team_five = FantasticTeam.create!({ name: 'EE', abbreviation: 'EE', hood:'EE'})
     team_six = FantasticTeam.create!({ name: 'FF', abbreviation: 'FF', hood:'FF'})

     team_one.division = division
     assert_equal division, team_one.division
     team_two.division = division
     assert_equal division, team_two.division
     team_three.division = division
     assert_equal division, team_three.division
     team_four.division = division
     assert_equal division, team_four.division
     team_five.division = division
     assert_equal division, team_five.division


  end
end

require 'test_helper'

class DivisionTest < ActiveSupport::TestCase
  test "division has not more than five teams" do
     division = Division.create! {name: "Drake - Headlines"}
     assert_equal 0, division.teams.count

     team_one = FantasticTeam.create! { name: 'A', abbreviation: 'A', hood:'A'}
     team_two = FantasticTeam.create! { name: 'B', abbreviation: 'B', hood:'b'}
     team_three = FantasticTeam.create! { name: 'C', abbreviation: 'C', hood:'C'}
     team_four = FantasticTeam.create! { name: 'D', abbreviation: 'D', hood:'D'}
     team_five = FantasticTeam.create! { name: 'E', abbreviation: 'E', hood:'E'}
     team_six = FantasticTeam.create! { name: 'F', abbreviation: 'F', hood:'F'}

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

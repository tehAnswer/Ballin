class LeagueCreation

  def self.create(params)
    league = League.new(params)
    return nil unless league.save
    eastern_conference = Conference.create!(name: 'East')
    western_conference = Conference.create!(name: 'West')

    atlantic_division = Division.create!(name: 'Atlantic')
    central_division = Division.create!(name: 'Central')
    southeast_division = Division.create!(name: 'Southeast')
    northwest_division = Division.create!(name: 'Northwest')
    pacific_division = Division.create!(name: 'Pacific')
    southwest_division = Division.create!(name: 'Southwest')

    atlantic_division.conference = eastern_conference
    eastern_conference.division_two = central_division
    eastern_conference.division_three = southeast_division

    western_conference.division_one = northwest_division
    western_conference.division_two = pacific_division
    western_conference.division_three = southwest_division

    league.eastern_conference = eastern_conference
    league.western_conference = western_conference
    return league
  end
end
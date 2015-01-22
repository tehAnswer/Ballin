class LeagueCreation

  def self.create(params)
    league = League.new(params)
    return league unless league.save

    eastern_conference = Conference.create!(name: 'East')
    western_conference = Conference.create!(name: 'West')

    atlantic_division = Division.create!(name: 'Atlantic')
    central_division = Division.create!(name: 'Central')
    southeast_division = Division.create!(name: 'Southeast')
    northwest_division = Division.create!(name: 'Northwest')
    pacific_division = Division.create!(name: 'Pacific')
    southwest_division = Division.create!(name: 'Southwest')

    atlantic_division.conference = eastern_conference
    central_division.conference = eastern_conference
    southeast_division.conference = eastern_conference
    #eastern_conference.division_two = central_division
    #eastern_conference.division_three = southeast_division

    northwest_division.conference = western_conference
    pacific_division.conference = western_conference
    southwest_division.conference = western_conference
    #western_conference.division_one = northwest_division
    #western_conference.division_two = pacific_division
    #western_conference.division_three = southwest_division

    eastern_conference.league = league
    western_conference.league = league
    return league
  end
end
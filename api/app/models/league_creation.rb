class LeagueCreation
  extend AbstractTransaction

  def self.create(params)
    self.transaction do
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

      eastern_conference.divisions << [atlantic_division, central_division, southeast_division]
      western_conference.divisions << [northwest_division, pacific_division, southwest_division]
      

      league.conferences << eastern_conference
      league.conferences << western_conference
      league.save!
      return league
    end
  end
end
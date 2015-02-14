namespace :test do

  task setup: :environment do
    Neo4j::Session.query("match (n)-[r]-(d) delete r,n,d")
    Neo4j::Session.query("match (n) delete n")

    User.create!({username: "Adolfo", email:"adolfo@dolf.com", password:"adolfoadolfo"})
    User.create!({username: "Second", email:"s@dolf.com", password:"secondsecond", is_admin: true})
    User.create!({username: "Eric Cartman", email:"ihatekyle@gmail.com", password:"ihatekyle"})
    user = User.create!({username: "UserWithTeam", email:"userwithteam@gmail.com", password:"userwithteam"})

    kobe = Player.create!({
      name: 'Kobe Bryant',
      height_cm: 200,
      height_formatted: "6'1\"",
      weight_lb: 100,
      weight_kg: 50,
      position: 'SG',
      number: '24',
      birthplace: 'Philly',
      birthdate: Date.new,
      })

    Player.create!({
      name: 'PlayerWithoutTeam',
      height_cm: 200,
      height_formatted: "6'1\"",
      weight_lb: 100,
      weight_kg: 50,
      position: 'SG',
      number: '24',
      birthplace: 'Philly',
      birthdate: Date.new,
      })

    20.times do |i|
      Player.create!({
      name: "JohnDoe#{i}",
      height_cm: 200,
      height_formatted: "6'1\"",
      weight_lb: 100,
      weight_kg: 50,
      position: 'SG',
      number: '24',
      birthplace: 'Philly',
      birthdate: Date.new,
      })
    end

    NbaTeam.create!({team_id: 'philadephia-76-ers',
        abbreviation: 'PHI',
        name: 'Philadelphia 76ers',
        conference: 'East',
        division: 'Atlantic',
        site_name: 'Wells Fargo',
        city: 'Philadelphia',
        state: 'Pennsylvannia'})

    BoxScore.create!
    FantasticTeam.create!({
      name: "firsttt",
      abbreviation: "FST",
      hood: "São Paulo",
      headline: "Vrasssil"
      })

    team_data = {
      name: "TeamWithUser",
      abbreviation: "TEAM",
      hood: "São Paulo",
      headline: "Vrasssil"
      }

    league = LeagueCreation.create({name: "AllStarsTestingContest"})
    division = league.conferences.first.divisions.first
    team = FantasticTeamCreation.new.create(division, team_data, user)
    contract_creation = ContractCreation.new
    contract_creation.create(kobe, team)
    Rake::Task["test"].invoke
    
  end

end

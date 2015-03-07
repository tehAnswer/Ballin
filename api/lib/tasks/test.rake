namespace :test do

  task setup: :environment do
    Neo4j::Session.query("match (n)-[r]-(d) delete r,n,d")
    Neo4j::Session.query("match (n) delete n")

    User.create!({username: "Adolfo", email:"adolfo@dolf.com", password:"adolfoadolfo"})
    User.create!({username: "Second", email:"s@dolf.com", password:"secondsecond", is_admin: true})
    User.create!({username: "Eric Cartman", email:"ihatekyle@gmail.com", password:"ihatekyle"})
    user = User.create!({username: "UserWithTeam", email:"userwithteam@gmail.com", password:"userwithteam"})

    
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

    NbaTeam.create!({team_id: 'fewfwefwe',
        abbreviation: 'efwew',
        name: 'ewfwewef fwe',
        conference: 'fewfew',
        division: 'wfe',
        site_name: 'wfe few',
        city: 'fwefew',
        state: 'fwewe'})

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

    iverson = Player.create!({
      name: 'Allen Iverson',
      height_cm: 200,
      height_formatted: "6'1\"",
      weight_lb: 100,
      weight_kg: 50,
      position: 'PG',
      number: '3',
      birthplace: 'Philly',
      birthdate: Date.new,
      })

    shaq = Player.create!({
      name: 'Shaq',
      height_cm: 200,
      height_formatted: "6'1\"",
      weight_lb: 100,
      weight_kg: 50,
      position: 'C',
      number: '24',
      birthplace: 'Philly',
      birthdate: Date.new,
      })

    durant = Player.create!({
      name: 'Kevin Durant',
      height_cm: 200,
      height_formatted: "6'1\"",
      weight_lb: 100,
      weight_kg: 50,
      position: 'SF',
      number: '24',
      birthplace: 'Philly',
      birthdate: Date.new,
      })

    embiid = Player.create!({
      name: 'Joel Embiid',
      height_cm: 200,
      height_formatted: "6'1\"",
      weight_lb: 100,
      weight_kg: 50,
      position: 'PF',
      number: '24',
      birthplace: 'Philly',
      birthdate: Date.new,
      })

    Game.create!({
      game_id: "fafssf",
      status: "Completed",
      season_type: "Regular",
      start_date_time: DateTime.new.to_s,
      date_formatted: DateTime.new.strftime('%Y%m%d')
      })



    contract_creation = ContractCreation.new
    contract_creation.create(kobe, team)
    contract_creation.create(embiid, team)
    contract_creation.create(iverson, team)
    contract_creation.create(shaq, team)
    contract_creation.create(durant, team)
    Rake::Task["test"].invoke
    
  end

end

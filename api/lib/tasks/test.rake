namespace :test do

  task setup: :environment do
    Neo4j::Session.query("match (n)-[r]-(d) delete r,n,d")
    Neo4j::Session.query("match (n) delete n")

    user = User.create!({username: "Adolfo", email:"adolfo@dolf.com", password:"adolfoadolfo"})
    user.update_auth_code
    Player.create!({
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

    NbaTeam.create!({team_id: 'philadephia-76-ers',
        abbreviation: 'PHI',
        name: 'Philadelphia 76ers',
        conference: 'East',
        division: 'Atlantic',
        site_name: 'Wells Fargo',
        city: 'Philadelphia',
        state: 'Pennsylvannia'})

    BoxScore.create!
    
  end

end

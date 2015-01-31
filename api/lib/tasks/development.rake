namespace :development do
  task setup: :environment do
  	crawler = XmlStatsController.new
  	nba_start_date = Date.new(2014,10,28)
  	nba_end_date = Date.new(2015,4,16)
  	crawler.fetch_teams
  	crawler.update_rosters
  	crawler.get_scheduled_games(nba_start_date, nba_end_date)
  	crawler.get_boxscores_since(nba_start_date)
  end

end

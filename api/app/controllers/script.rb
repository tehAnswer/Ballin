require 'eventmachine'
require_relative '../../config/environment'
require_relative './market_update'

Dir["/app/models/**/*.rb"].each do |path|
  require path
end
while(true)
  leagues = League.all
  leagues.each do |league|
    Market.update(league)
    Market.create(league)
  end
  Market.daily_pay()
  sleep(86400)
end
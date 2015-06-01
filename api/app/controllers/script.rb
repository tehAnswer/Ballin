require 'eventmachine'
require_relative '../../config/environment'
require_relative './market_update'

Dir["/app/models/**/*.rb"].each do |path|
  require path
end

EventMachine.add_periodic_timer(86400) do
  leagues = League.all
  leagues.each do |league|
    Market.update(league)
    Market.create(league)
  end
end


while(true); end;
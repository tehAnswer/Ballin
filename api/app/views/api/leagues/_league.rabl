object @league

attributes :neo_id, :name, :number_of_teams

child :eastern_conference => :eastern_conference do
  extends "conferences/conference"
end

child :western_conference => :western_conference do
  extends "conferences/conference"
end
class LeagueSerializer < ActiveModel::Serializer
  attributes :neo_id, :name, :number_of_teams, :eastern_conference_id, :western_conference_id
  embed :ids
end
class LeagueSerializer < ActiveModel::Serializer
  attributes :neo_id, :name, :number_of_teams, :conferences_id
  embed :ids
end
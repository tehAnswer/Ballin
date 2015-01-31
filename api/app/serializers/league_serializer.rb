class LeagueSerializer < ActiveModel::Serializer
  attributes :neo_id, :name, :number_of_teams, :conference_ids
  embed :ids
end
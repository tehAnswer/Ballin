class NbaTeamSerializer < ActiveModel::Serializer
  attributes :neo_id, :name, :team_id, :conference, :division, :site_name, :city,
    :state, :abbreviation, :game_ids, :player_ids
end
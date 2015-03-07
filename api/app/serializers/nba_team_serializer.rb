class NbaTeamSerializer < ActiveModel::Serializer
  attributes :neo_id, :name, :team_id, :conference, :division, :site_name, :city,
    :state, :abbreviation, :away_game_ids, :home_game_ids, :player_ids, :next_gameid
end
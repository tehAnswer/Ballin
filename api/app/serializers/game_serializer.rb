class GameSerializer < ActiveModel::Serializer
  attributes :neo_id, :away_team_id, :home_team_id, :away_score, :home_score, :away_boxscore_ids, :home_boxscore_ids,
    :season_type, :start_date_time, :status, :date_formatted, :game_id
end
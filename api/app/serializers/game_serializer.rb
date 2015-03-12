class GameSerializer < ActiveModel::Serializer
  attributes :neo_id, :away_team_id, :home_team_id, :away_score, :home_score, :box_score_ids,
    :season_type, :date_time, :status, :date_formatted, :title
end
class PlayerSerializer < ActiveModel::Serializer
  attributes :neo_id, :name, :height_cm, :height_formatted, :weight_lb, :weight_kg, :position, :number, :birthplace, :birthdate, :stats, :box_score_ids, :nba_team_id
  embed :ids
end

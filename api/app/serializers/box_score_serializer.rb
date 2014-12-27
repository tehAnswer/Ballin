class BoxScoreSerializer < ActiveModel::Serializer
  attributes :neo_id, :minutes, :is_starter, :points, :assists,
    :fga, :fgm, :fta, :ftm, :lsa, :lsm, :turnovers, :steals, :blocks,
    :faults, :player_id, :defr, :ofr, :final_score
    embed :ids
end

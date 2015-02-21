class ContractSerializer < ActiveModel::Serializer
  attributes :neo_id, :player_id, :team_id, :league_id
end
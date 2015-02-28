class FantasticTeamSerializer < ActiveModel::Serializer
	attributes :neo_id, :name, :hood, :abbreviation, :headline, :user_id, :contract_ids, :rotation_id
end
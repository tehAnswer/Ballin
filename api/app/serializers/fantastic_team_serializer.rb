class FantasticTeamSerializer < ActiveModel::Serializer
	attributes :neo_id, :name, :hood, :abbreviation, :headline, :user_id, :contract_ids, :rotation_id, :score, :budget, :division_id
end
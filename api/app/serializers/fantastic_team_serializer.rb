class FantasticTeamSerializer < ActiveModel::Serializer
	attributes :neo_id, :name, :hood, :abbreviation, :headline, :user_id
end
class ConferenceSerializer < ActiveModel::Serializer
	attributes :neo_id, :name, :division_ids
end
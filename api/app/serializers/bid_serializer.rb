class BidSerializer < ActiveModel::Serializer
  attributes :neo_id, :salary, :team_id, :auction_id
end
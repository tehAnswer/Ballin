class AuctionSerializer < ActiveModel::Serializer
  attributes :neo_id, :player_id, :bid_ids, :max_bid_id, :end_time
end
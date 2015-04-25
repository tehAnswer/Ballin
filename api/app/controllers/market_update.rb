require 'byebug'
class Market
  extend AbstractTransaction

  def self.update(league)
    transaction do
      auctions = league.auctions
      auctions.each do |auction|
        if auction.end_time.past?
          process_auction(auction)
        end
      end
      create_auctions(league)
      return true
    end
  end

  def self.process_auction(auction)
    max_bid = auction.max_bid
    create_contract(auction, max_bid) if max_bid.persisted?
    auction.destroy
  end

  def self.create_contract(auction, bid)
    creation = ContractCreation.new
    params = { league_id: auction.league_id, player_id: auction.player_id }
    result = Neo4j::Session.query("MATCH (l:League)-[:LEAGUE]-(c:Contract)-[:PLAYER]->(p:Player) where id(l) = {league_id} and id(p) = {player_id} return c", params).first
    previous_contract = result.nil? ? nil : result["c"]
    previous_contract.destroy if previous_contract
    contract = creation.create(auction.player, bid.team, bid.salary)
    debugger
    previous_contract.team.budget += bid.salary if previous_contract
    previous_contract.team.save if previous_contract
    raise "Error. Error" unless contract && contract.persisted?
  end

  def self.create_auctions(league)
   # "MATCH (p:Player),(c:Contract),(l)
   # where not (p)<-[:PLAYER]-(c)-[:LEAGUE]->(l) and id(l)=
   # with p,c,l,rand() as _number
   # order by _number limit 3
   # create (p)<-[:PLAYER]-(ac:Auction {end_time: })-[:LEAGUE]->(l)"
  end
end
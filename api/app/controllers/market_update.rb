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
      return true
    end
  end

  def self.create(league)
    create_auctions(league)
  end

  def self.process_auction(auction)
    max_bid = auction.max_bid
    create_contract(auction, max_bid) if max_bid.persisted?
    auction.destroy
  end

  def self.create_contract(auction, bid)
    creation = ContractCreation.new
    params = { league_id: auction.league_id, player_id: auction.player_id }
    query = "MATCH (l:League)<-[:LEAGUE]-(c:Contract)-[:PLAYER]->(p:Player) where id(l)={league_id} and id(p)={player_id} return c"
    result = Neo4j::Session.query(query, params).first
    previous_contract = result.nil? ? nil : result["c"]
    contract = creation.create(auction.player, bid.team, bid.salary)
    previous_contract.team.budget += bid.salary if previous_contract
    previous_contract.team.save if previous_contract
    previous_contract.destroy if previous_contract
    # raise "Error. Error" unless contract && contract.persisted?
  end

  def self.create_auctions(league)
   query = "MATCH (p:Player),(l:League)
   where not (p)<-[:PLAYER]-(:Contract)-[:LEAGUE]->(l) and NOT (p)<-[:PLAYER]-(:Auction)-[:LEAGUE]->(l) and id(l)={league_id}
   with p,l,rand() as _number
   order by _number limit 3
   create (p)<-[:PLAYER]-(ac:Auction)-[:LEAGUE]->(l)
   set ac.end_time={end_time}"
   params = { league_id: league.neo_id, end_time: 3.days.from_now }
   Neo4j::Session.query(query, params)
  end

  def self.daily_pay
    Neo4j::Session.query("MATCH (ft:FantasticTeam) set ft.budget = ft.budget + {salary}", salary: 100_000);
  end
end
require 'nokogiri'
require 'open-uri'
 
class XmlStatsScrapper
	attr_accessor :base_uri
	include HeightHelper
 
	def initialize()
		self.base_uri = 'https://www.erikberg.com'
	end
	
 
	def fetch_player_from_game(player_name, game_id)
		link = get_player_link(player_name, game_id)
		return nil if link.nil?
		data = extract(link)
		create_player(data)
	end
 
	def get_player_link(player_name, game_id)
		doc = get("/nba/boxscore/#{game_id}")
		doc.xpath('//td/a').each do |link|
			return link['href'] if link.content == player_name
		end
		nil
	end
 
 
	def extract(link)
		ret = []
		doc = get(link)
		path = "//div[@class='span5 table-shadow wtdgrad']/div/table/tr/td"
		doc.xpath(path).each do |td|
			ret << td.content.split("\s")
		end
		doc.xpath("//small").each do |description|
			ret << description.content
		end
		return ret
	end
 
	def create_player(data)
		debugger
		Player.create!({
			name: data[0].join(" "),
			birthdate: Date.strptime(data[2][0], "%m/%d/%y").strftime('%Y-%m-%d'),
			birthplace: data[1].join(" "),
			height_cm: height_cm(data[3][0]),
      height_formatted: data[3][0],
      weight_lb: data[4][0].to_i,
      weight_kg: (data[4][0].to_i*0.45).to_s,
      position: position(data.last),
			})
	end
 
	def position(data)
		if data.include? ("Shooting Guard")
			return 'SG'
		elsif data.include?("Guard")
			return 'G'
		elsif data.include?("Point Guard")
			return 'PG'
		elsif data.include?("Small Forward")
			return 'SF'
		elsif data.include?("Forward")
			return 'F'
		elsif data.include?("Power Forward")
			return 'PF'
		elsif data.include?("Center")
			return 'C'
		end
	end
 
 
	def get(path)
		Nokogiri::HTML(open(base_uri+ path))
  end
 
end
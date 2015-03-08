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
    position = get_player_position(player_name, game_id)
    return nil if link.nil?
    data = extract(link)
    player = create_player(player_name, data, position)
    return player
  end
 
  def get_player_link(player_name, game_id)
    doc = get("/nba/boxscore/#{game_id}")
    doc.xpath('//td/a').each do |link|
      return link['href'] if link.content == player_name
    end
    nil
  end

  def get_player_position(player_name, game_id)
    doc = get("/nba/boxscore/#{game_id}")
    path = "//table[@class='box-nba table-bordered table-rounded table-striped-gray']/tbody/tr/*[1]"
    doc.xpath(path).each do |td|
      content = td.content.split(/[\s,]/)
      return content.last if td.content.include?(player_name)
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
    return ret
  end
 
  def create_player(player_name, data_extracted, position)
    data = data_extracted.reverse.take(4)
    Player.create({
      name: player_name,
      birthdate: Date.strptime(data[2][0], "%m/%d/%y").strftime('%Y-%m-%d'),
      birthplace: data[3].join(" "),
      height_cm: height_cm(data[1][0]),
      height_formatted: data[1][0],
      weight_lb: data[0][0].to_i,
      weight_kg: (data[0][0].to_i*0.45).to_s,
      position: position
    })
  end
 
  def get(path)
    Nokogiri::HTML(open(base_uri+ path))
  end
 
end
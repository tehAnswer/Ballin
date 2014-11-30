class Crawler

  def self.crawl
    x = XmlStatsController.new
    x.get_boxscores(1.day.ago)
    x.update_rosters
  end


end
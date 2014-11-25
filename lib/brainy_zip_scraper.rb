require "brainy_zip_scraper/scraper"
require "brainy_zip_scraper/version"

module BrainyZipScraper
  def self.to_csv(path)
    scraper = Scraper.new
    scraper.to_csv(path)
    puts "Updated #{path}"
  end
end

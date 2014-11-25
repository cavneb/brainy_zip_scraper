require 'nokogiri'
require 'open-uri'
require 'ruby-progressbar'
require 'csv'

class Scraper
  def urls
    pages = []
    pages << "http://www.brainyzip.com/state/zip_alabama.html"
    pages << "http://www.brainyzip.com/state/zip_alaska.html"
    pages << "http://www.brainyzip.com/state/zip_arizona.html"
    pages << "http://www.brainyzip.com/state/zip_arkansas.html"
    pages << "http://www.brainyzip.com/state/zip_california.html"
    pages << "http://www.brainyzip.com/state/zip_colorado.html"
    pages << "http://www.brainyzip.com/state/zip_connecticut.html"
    pages << "http://www.brainyzip.com/state/zip_delaware.html"
    pages << "http://www.brainyzip.com/state/zip_districtofcolumbia.html"
    pages << "http://www.brainyzip.com/state/zip_florida.html"
    pages << "http://www.brainyzip.com/state/zip_georgia.html"
    pages << "http://www.brainyzip.com/state/zip_hawaii.html"
    pages << "http://www.brainyzip.com/state/zip_idaho.html"
    pages << "http://www.brainyzip.com/state/zip_illinois.html"
    pages << "http://www.brainyzip.com/state/zip_indiana.html"
    pages << "http://www.brainyzip.com/state/zip_iowa.html"
    pages << "http://www.brainyzip.com/state/zip_kansas.html"
    pages << "http://www.brainyzip.com/state/zip_kentucky.html"
    pages << "http://www.brainyzip.com/state/zip_louisiana.html"
    pages << "http://www.brainyzip.com/state/zip_maine.html"
    pages << "http://www.brainyzip.com/state/zip_maryland.html"
    pages << "http://www.brainyzip.com/state/zip_massachusetts.html"
    pages << "http://www.brainyzip.com/state/zip_michigan.html"
    pages << "http://www.brainyzip.com/state/zip_minnesota.html"
    pages << "http://www.brainyzip.com/state/zip_mississippi.html"
    pages << "http://www.brainyzip.com/state/zip_missouri.html"
    pages << "http://www.brainyzip.com/state/zip_montana.html"
    pages << "http://www.brainyzip.com/state/zip_nebraska.html"
    pages << "http://www.brainyzip.com/state/zip_nevada.html"
    pages << "http://www.brainyzip.com/state/zip_newhampshire.html"
    pages << "http://www.brainyzip.com/state/zip_newjersey.html"
    pages << "http://www.brainyzip.com/state/zip_newmexico.html"
    pages << "http://www.brainyzip.com/state/zip_newyork.html"
    pages << "http://www.brainyzip.com/state/zip_northcarolina.html"
    pages << "http://www.brainyzip.com/state/zip_northdakota.html"
    pages << "http://www.brainyzip.com/state/zip_ohio.html"
    pages << "http://www.brainyzip.com/state/zip_oklahoma.html"
    pages << "http://www.brainyzip.com/state/zip_oregon.html"
    pages << "http://www.brainyzip.com/state/zip_pennsylvania.html"
    pages << "http://www.brainyzip.com/state/zip_rhodeisland.html"
    pages << "http://www.brainyzip.com/state/zip_southcarolina.html"
    pages << "http://www.brainyzip.com/state/zip_southdakota.html"
    pages << "http://www.brainyzip.com/state/zip_tennessee.html"
    pages << "http://www.brainyzip.com/state/zip_texas.html"
    pages << "http://www.brainyzip.com/state/zip_utah.html"
    pages << "http://www.brainyzip.com/state/zip_vermont.html"
    pages << "http://www.brainyzip.com/state/zip_virginia.html"
    pages << "http://www.brainyzip.com/state/zip_washington.html"
    pages << "http://www.brainyzip.com/state/zip_westvirginia.html"
    pages << "http://www.brainyzip.com/state/zip_wisconsin.html"
    pages << "http://www.brainyzip.com/state/zip_wyoming.html"
    pages
  end

  def parse_page(url)
    doc = Nokogiri::HTML(open(url))
    trs = doc.xpath("//center[3]/table/tr[2]/td[1]/table/tr")
    rows = []
    trs.each_with_index do |tr, index|
      next if index == 0
      row = []
      tr.children.each_with_index do |td, idx|
        val = td.text.strip.gsub(' zip code', '')
        row << val
      end
      rows << row
    end
    rows
  end

  def to_csv(path)
    progressbar = ProgressBar.create(
      :title => 'Zip Codes by State',
      :starting_at => 0,
      :total => urls.length,
      :format => '%a |%b>>%i| %p%% %t'
    )

    csv_rows = []
    csv_rows << ["zip_code", "city", "state", "county", "population"]

    urls.each do |page|
      csv_rows = csv_rows + parse_page(page)
      progressbar.increment
      csv_rows
    end

    CSV.open(path, "w") do |csv|
      csv_rows.each do |row|
        csv << row
      end
    end

    path
  end
end

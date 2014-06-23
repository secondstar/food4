# like camera
require 'nokogiri'
require 'open-uri'

class DfbHarvester
  def initialize(target)
    @target = target
  end
  
  attr_accessor :notebook
  
  
  def scrape_review_listing_page
    doc = Nokogiri::HTML(open(URI.encode(yql_url)))
    links = Hash.new
    doc.css("a").each do |link|
      permalink = link['href']
      permalink = permalink.blank? ? "" : permalink.gsub(/.*\.disneyfoodblog.com\//,'')
      permalink = permalink.gsub(/\/$/,'')
      name = link['content'].blank? ? get_name_from_dfb_permalink(permalink) : link['content'].gsub(/\W/,' ')
      # puts permalink + ' for ' + name
      links.store(name, permalink)
    end
    # puts "#{links}"
    
    results = [links]
    results[0].keys[0..2].each {|r| results[0].delete(r) } #Take out the first three because they're kruft
    return results
    
  end
  
  def scrape_eatery_review_page
    # next to do
  end
  
  def get_name_from_dfb_permalink(permalink)
    return permalink.gsub(/\W/,' ').gsub(/\b\w/) { $&.upcase }
  end
  
  def yql_url
    yql_base_url = 'http://query.yahooapis.com/v1/public/yql'
    yql_select_statment = "use 'http://yqlblog.net/samples/data.html.cssselect.xml' as data.html.cssselect; select * from data.html.cssselect where url= \'#{@target.url}\' and css='div.entry-content p a'"

    yql_url = "#{yql_base_url}?q=#{yql_select_statment}&format=xml"
  end
end
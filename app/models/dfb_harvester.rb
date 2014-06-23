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
    # return doc
    links = Hash.new
    doc.css("a").each do |link|
      permalink = link['href']
      permalink = permalink.blank? ? "" : permalink.gsub(/.*\.disneyfoodblog.com\//,'')
      permalink = permalink.gsub(/\/$/,'')
      name = link['content'].blank? ? self.get_name_from_dfb_permalink(permalink) : link['content'].gsub(/\W/,' ')
      links.store(name, permalink)
    end
    keys = links.keys[0..2] #Take out the first three because they're kruft
    keys.each {|key| links.delete(key) }
    [links]
    
  end
  
  def scan_review_details
    # puts "url is: #{(URI.encode(yql_url))}"
    doc = Nokogiri::HTML(open(URI.encode(yql_url)))
    eatery_values_hash = {}
    eatery_values_hash.default = ""
    # Get a Nokogiri::HTML:Document for the page we’re interested in...
    doc.css("p").each do |item|
        if item.to_s =~ /<strong>/
          # puts "first first #{dbf_item(item).first.first}"
          # puts "---"
          # puts "first last #{dbf_item(item).first.last}"
          # puts "---"
          h = Hash.new
          h.default = ""
          title = dbf_item(item).first.first
          desc = dbf_item(item).first.last
          h.store(title, desc)
          # puts "================================"
          # eatery_values_hash += h
          # eatery_values_hash.merge!h
          # eatery_values_hash = Hash.try_convert(eatery_values_array)
          # puts "The description for #{h.key(desc)} is #{h.fetch(title)}" # + h.first.to_s
          eatery_values_hash.store(title, desc)
          # puts"#{eatery_values_hash.fetch(title)}"
        end
    end

    # puts "all values"
    # puts "eatery_values_hash"
    return [eatery_values_hash]
    
  end
  
  def dbf_item(service_desc)
     desc = service_desc.to_s.split('</strong>').last
     desc = desc.split('</p>').first
     desc = desc.to_s.lstrip
     title = service_desc.to_s.split('</strong>').first
     title = title.gsub(/.*<strong>/, "")
     title = title.gsub(/:$/, "")
    detail = {title => desc}
    
    return detail
  end
  
  def get_name_from_dfb_permalink(permalink)
    return permalink.gsub(/\W/,' ').gsub(/\b\w/) { $&.upcase }
  end
  
  def yql_url
    yql_base_url = 'http://query.yahooapis.com/v1/public/yql'
    yql_select_statment = "use 'http://yqlblog.net/samples/data.html.cssselect.xml' as data.html.cssselect; select * from data.html.cssselect where url= \'http://www.disneyfoodblog.com#{@target.path}\' and css = '#{@target.yql_css_parse}'"
    # puts "yql_select_statement: #{yql_select_statment}"

    yql_url = "#{yql_base_url}?q=#{yql_select_statment}&format=xml"
    # puts "@target.path: #{@target.path}"
    # puts "yql_url: #{yql_url}"
  end
end
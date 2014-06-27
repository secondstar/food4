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
    #Take out the first three because they're kruft.
    bad_keys = links.keys[0..2]
    # # Scraping these are painful. Maybe later.
    # bad_keys.insert(3,"Be Our Guest Restaurant", "Aunt Pollys", "Gastons Tavern", "Tomorrowland Terrace Cafe", "Tomorrowland Terrace Restaurant", "Tonys Town Square", "Sunshine Tree Terrace", "Storybook Treats", "Sleepy Hollow", "The Plaza Restaurant", "Pinocchios Village Haus", "Pecos Bills Tall Tale Inn And Cafe", "Main Street Ice Cream Parlor", "Main Street Bakery", "The Lunching Pad")
    # puts bad_keys
    # puts "Number of bad_keys #{bad_keys.length}, length of links hash #{links.length}"
    bad_keys.each {|key| links.delete(key) }
    # puts "links - bad_keys  #{links.length}"
    [links]
    
  end
  
  def scan_review_details
    doc = Nokogiri::HTML(open(URI.encode(yql_url)))
    puts "doc p doesn't exists? #{doc.css("p").blank?}"
    eatery_values_hash = Hash.new
    return [eatery_values_hash] if doc.css("p").blank? #404 error or no such results page at DFB
    eatery_values_hash.default = ""
    # Get a Nokogiri::HTML:Document for the page we’re interested in...
    doc.css("p").each do |item|
        if item.to_s =~ /<strong>/
          h = Hash.new
          h.default = ""
          title = dbf_item(item).first.first.downcase.tr(" ", "_")
          desc = dbf_item(item).first.last
          h.store(title, desc)
          eatery_values_hash.store(title, desc)
        end
    end
    # puts eatery_values_hash
    eatery_values_hash.delete("allears.net")
    eatery_values_hash.delete("to_book_a_reservation")
    eatery_values_hash.delete("restaurant.com_gift_certificate")
    eatery_values_hash.delete("saratoga_lager")
    eatery_values_hash.delete("for_information_on_other_walt_disney_world_table_service_restaurants,_head_to_our_")
    # puts eatery_values_hash
    swap_title(eatery_values_hash)
    return [eatery_values_hash]
    
  end
  
  def dbf_item(service_desc)
     desc = service_desc.to_s.split('</strong>').last
     desc = desc.split('</p>').first
     desc = desc.to_s.lstrip
     title = service_desc.to_s.split('</strong>').first
     title = title.gsub(/.*<strong>/, "")
     title = title.gsub(/:$/, "").split(":").first
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
  
  def swap_title(eatery_values_hash)
    #When scanning review details, the title in the DB doesn't always match the column name
    #posts_mentioning -- the key created varies, so we search for it and replace it
    if eatery_values_hash.select { |key, value| key.start_with? 'disney_food_blog_posts_mentioning' }.length > 0
      posts_mentioning = eatery_values_hash.select { |key, value| key.start_with? 'disney_food_blog_posts_mentioning' }.first.first
      eatery_values_hash["mentioned_in"] = eatery_values_hash[posts_mentioning]
      eatery_values_hash.delete(posts_mentioning)      
    end
    #other_table_service -- the key has a comma in it, so we search for it and replace it
    if eatery_values_hash.select { |key, value| key.start_with? 'for_information_on_other_walt_disney_world' }.length > 0
      other_table_service = eatery_values_hash.select { |key, value| key.start_with? 'for_information_on_other_walt_disney_world' }.first.first
      eatery_values_hash.delete(other_table_service)      
    end
    #important_info - we know the key, so we swap it out directly
    eatery_values_hash["important_info"] =  eatery_values_hash.fetch("important_information",
                                            eatery_values_hash["important_info"])
    eatery_values_hash.delete("important_information")
    #famous_drinks/dishes - we know the key, so we swap it out directly
    eatery_values_hash["famous_dishes"] =   eatery_values_hash.fetch("famous_drinks/dishes",
                                            eatery_values_hash["famous_dishes"])
    eatery_values_hash.delete("famous_drinks/dishes")
    #famous_drinks - we know the key, so we swap it out directly
    eatery_values_hash["famous_dishes"] =   eatery_values_hash.fetch("famous_drinks",
                                            eatery_values_hash["famous_dishes"])
    
    eatery_values_hash.delete("famous_drinks")
    #famous_drinks - we know the key, so we swap it out directly
    eatery_values_hash["famous_dishes"] =   eatery_values_hash.fetch("best_eats",
                                            eatery_values_hash["famous_dishes"])
    
    eatery_values_hash.delete("best_eats")    
  end
end
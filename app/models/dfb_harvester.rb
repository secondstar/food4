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
  
  def scan_for_addendums
    doc = Nokogiri::HTML(open(URI.encode(yql_url)))
    # bloggings = scan_for_bloggings
    tips = scan_for_tips(doc)
    # affinities = scan_for_affinities
    results = [] << tips
  end
  def scan_for_tips
      doc = Nokogiri::HTML(open(URI.encode(yql_url)))
      array_of_paragraphs = []

      doc.css("p").each_with_index {|p| array_of_paragraphs << p.to_s}

      indexed_paragraphs_hash = Hash.new

      array_of_paragraphs.each_with_index {|item, index| indexed_paragraphs_hash[index] = item }

      index_number_of_the_heading_of_section = indexed_paragraphs_hash.select {|k,v| v =~ /<strong>Important Inf/}.keys.first # gives us the index number of the paragraph of the section we want

      section_headings_index_numbers = indexed_paragraphs_hash.select {|k,v| v =~ /<strong>/}.keys # an array


      index_of_next_section_heading =
         section_headings_index_numbers[section_headings_index_numbers.find_index(index_number_of_the_heading_of_section).to_i + 1]

      result = []#array_of_paragraphs #[]
      array_of_paragraphs[(index_number_of_the_heading_of_section.to_i + 1)..(index_of_next_section_heading.to_i - 1)].each do |i|
      # array_of_paragraphs[(index_number_of_the_heading_of_section.to_i)..(index_of_next_section_heading.to_i)].each do |i|
      	result << i.split("p>")[1].gsub("</", "")
      end
      return result
  end
  
  def scan_review_details
    # # puts "old @target #{@target}"
    # add_review_permalink_to_target
    # @target.path = "/#{DfbBridge.new(@target).get_review_permalink}"
    # puts "new @target #{@target}"
    # #now that we have the proper path
    doc = Nokogiri::HTML(open(URI.encode(yql_url)))
    # puts "doc p doesn't exists? #{doc.css("p").blank?}"
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
    # These hash values are bold text on the webpage that we key off of.  The are not values we care about.
    eatery_values_hash.delete("allears.net")
    eatery_values_hash.delete("moosehead_and_red_hook") # Trout Pass
    eatery_values_hash.delete("as_of_july_17th,_2013,_dinner_buffets_are_only_held_on_friday_evenings.") # Garden Grove Cafe
    eatery_values_hash.delete("to_make_reservations") # Queen Victoria’s Room at Victoria and Albert’s Restaurant
    eatery_values_hash.delete("breakfast") # Gasparilla Island Grill
    eatery_values_hash.delete("lunch_&amp;_dinner") # Gasparilla Island Grill
    eatery_values_hash.delete("dessert") # Gasparilla Island Grill
    eatery_values_hash.delete("monsieur_paul") # Monsieur Paul Restaurant
    eatery_values_hash.delete("reviews_of_bistro_de_paris") # Monsieur Paul Restaurant
    eatery_values_hash.delete("update")
eatery_values_hash.delete("choice_of_ordering_their_ice_cream_or_sorbet_in_one-_or_two-scoop_sizes,_in_either_a_cone_or_a_cup.") # L’Artisan des Glaces Sorbet and Ice Cream Shop in Epcot
eatery_values_hash.delete("pastel_colors_and_old-world_structural_touches") # L’Artisan des Glaces Sorbet and Ice Cream Shop in Epcot
eatery_values_hash.delete('is_l’artisan_des_glaces_on_your_list_for_your_next_trip?_let_us_know_in_the_comments_below!') # L’Artisan des Glaces Sorbet and Ice Cream Shop in Epcot
eatery_values_hash.delete('one_scoop_cone/cup_can_be_purchased_for_a_<a_href="http') # L’Artisan des Glaces Sorbet and Ice Cream Shop in Epcot
eatery_values_hash.delete("featuring_sixteen_icy,_delicious_flavors_") # L’Artisan des Glaces Sorbet and Ice Cream Shop in Epcot
eatery_values_hash.delete("grand_marnier") # L’Artisan des Glaces Sorbet and Ice Cream Shop in Epcot
eatery_values_hash.delete("sorbet") # L’Artisan des Glaces Sorbet and Ice Cream Shop in Epcot
eatery_values_hash.delete("ice_cream") # L’Artisan des Glaces Sorbet and Ice Cream Shop in Epcot
    eatery_values_hash.delete("wine_and_beer_options_available") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("what_items_are_you_most_excited_to_try_at_the_new_les_halles_boulangerie_patisserie_in_epcot’s_france?_let_us_know_in_the_comments_below!") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("separate_cafe_window_to_the_left_of_the_main_serving_queue,_which_only_offers_beverages") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("soft_desserts") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("napoleon") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("pastries") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("half_baguettes") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("pumpkin_soup") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("cheese_plate") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("pissaladiere") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("quiche_florentine") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("poulet_au_pistou") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("the_les_halles_items_were_bold,_featuring_strong,_authentic_flavors") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("soups,_salads,_hot_and_cold_sandwiches,_quiche,_bread,_and_cheeses") # Epcot’s Les Halles Bakery
    eatery_values_hash.delete("what_are_your_thoughts_on_the_new_starbucks_format_at_fountain_view?_chime_in!") # Fountain View Cafe
    eatery_values_hash.delete("first_look_of_the_new_fountain_view_cafe_doing_business_as_a_starbucks!") # Fountain View Cafe
    eatery_values_hash.delete("note") # Cool Wash Pizza"
    eatery_values_hash.delete("real_tableware") # Be Our Guest
    eatery_values_hash.delete("cracked_door_arch") # Be Our Guest
    eatery_values_hash.delete("entryway_mosaics") # Be Our Guest
    eatery_values_hash.delete("be_our_guest_restaurant_menu") # Be Our Guest
    eatery_values_hash.delete('<a_href="http') # Be Our Guest
    eatery_values_hash.delete('see_our_<a_href="http') # Be Our Guest    
    eatery_values_hash.delete("to_book_a_reservation")
    eatery_values_hash.delete("restaurant.com_gift_certificate") # Shulas's
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
  
  # def add_review_permalink_to_target
  #   params = @target.to_h
  #   review_permalink = params[:path].gsub("/","")
  #   params2 = {review_permalink: review_permalink}
  #   params = params.merge(params2)
  #   @target = OpenStruct.new(params)
  # end
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
    #best_eats - we know the key, so we swap it out directly
    eatery_values_hash["famous_dishes"] =   eatery_values_hash.fetch("best_eats",
                                            eatery_values_hash["famous_dishes"])
    
    eatery_values_hash.delete("famous_eats")
    #famous_eats - we know the key, so we swap it out directly
    eatery_values_hash["famous_dishes"] =   eatery_values_hash.fetch("famous_eats",
                                            eatery_values_hash["famous_dishes"])
    
    eatery_values_hash.delete("best_eats")
    #menus - we know the key, so we swap it out directly
    eatery_values_hash["famous_dishes"] =   eatery_values_hash.fetch("menus",
                                            eatery_values_hash["menu"])
    
    eatery_values_hash.delete("menus")    
    #reviews - we know the key, so we swap it out directly
    eatery_values_hash["reviews"] =   eatery_values_hash.fetch("review",
                                            eatery_values_hash["reviews"])
    
    eatery_values_hash.delete("review")    
  end
  
  # def scan_for_tips(doc)
  #   results = Hash.new
  #   results.default = {}
  #   # Get a Nokogiri::HTML:Document for the page we’re interested in...
  #   doc.css("p").each do |item|
  #       if item.to_s =~ /<strong>Important Info/
  #         h = Hash.new
  #         h.default = ""
  #         title = dbf_item(item).first.first.downcase.tr(" ", "_")
  #         desc = dbf_item(item).first.last
  #         h.store(title, desc)
  #         results.store(title, desc)
  #       end
  #   end
  #
  #   return results
  # end
end
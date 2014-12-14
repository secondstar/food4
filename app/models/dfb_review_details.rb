class DfbReviewDetails
  def initialize(args)
    @target =  args[:target]
    yql_url = DfbYqlCollector.new(target).yql_url
    @doc = Nokogiri::HTML(open(yql_url))
  end
  
  attr_accessor :notebook, :target, :doc
  
  def scan
    eatery_values_hash = Hash.new
    return [eatery_values_hash] if doc.css("p").blank? #404 error or no such results page at DFB
    eatery_values_hash.default = ""
    # Get a Nokogiri::HTML:Document for the page we’re interested in...
    doc.css("p").each do |item|
        if item.to_s =~ /<strong>/
          h = Hash.new
          h.default = ""
          title = _dfb_item(item).first.first.downcase.tr(" ", "_")
          # strips non-breaking space & whitespace that's leading and trailing 
          title = title.gsub(/\A\p{Space}*|\p{Space}*\z/, '')
          desc = _dfb_item(item).first.last
          h.store(title, desc)
          eatery_values_hash.store(title, desc)
        end
    end
    # deal with inidividual review quirks
    # ==========================================
    # eatery_values_hash = _normalize_scan(eatery_values_hash)
    return eatery_values_hash
    
    # ==========================================
    ### the rest of this method will eventually be deleted after they have become factories ###
    ## -------------------------------------------------
    # puts eatery_values_hash
    # These hash values are bold text on the webpage that we key off of.  The are not values we care about.
    # eatery_values_hash.delete(" important_information") # Turf Club Lounge
    eatery_values_hash.delete("allears.net")
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
    # swap_title(eatery_values_hash)
    return [eatery_values_hash]
    
  end
  
  def _dfb_item(service_desc)
     desc = service_desc.to_s.split('</strong>').last
     desc = desc.split('</p>').first
     desc = desc.to_s.lstrip
     title = service_desc.to_s.split('</strong>').first
     title = title.gsub(/.*<strong>/, "")
     title = title.gsub(/:$/, "").split(":").first
    detail = {title => desc}
    
    return detail
  end
  
  def self.swap_title(eatery_values_hash)
    #When scanning review details, the title in the DB doesn't always match the column name
    #posts_mentioning -- the key created varies, so we search for it and replace it
    hash_of_dfb_posts_mentioning_this_eatery = eatery_values_hash.select { |key| key.match('\Adisney_food_blog_posts_mentioning*') }
    
    if hash_of_dfb_posts_mentioning_this_eatery.length > 0
      posts_mentioning = eatery_values_hash.select { |key, value|
         key.match('\Adisney_food_blog_posts_mentioning*') }.first.first
      eatery_values_hash["mentioned_in"] = eatery_values_hash[posts_mentioning]
      eatery_values_hash.delete(posts_mentioning)
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
    return eatery_values_hash
  end
    
  def _normalize_scan(eatery_values_hash)
    if permalinks_of_reviews_with_non_standard_format.include?(target.path)
      class_name = "Dfb" + target.path.to_s.titleize.gsub(" ","").gsub("/","") + "ReviewScan"
      normalized_details = class_name.constantize.new(eatery_values_hash).normalize      
    else
      normalized_details = eatery_values_hash
    end
    
    return normalized_details
  end
  
  def permalinks_of_reviews_with_non_standard_format
    permalinks = %w(turf-club
      trout-pass
      garden-grove-cafe
    victoria-and-alberts-restaurant
    gasparilla-grill-and-games
    monsieur-paul-restaurant
    2013/05/29/first-look-lartisan-des-glaces-sorbet-and-ice-cream-shop-in-epcots-france-is-open-see-full-menu-and-photos-here
    2013/01/15/review-epcots-les-halles-bakery
    2013/09/04/first-look-starbucks-opens-at-epcots-fountain-view-cafe
    cool-wash-pizza
    be-our-guest-restaurant
    shulas-steak-house
    artist-point
    )
  end
  
end
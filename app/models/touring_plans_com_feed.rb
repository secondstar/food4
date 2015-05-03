require 'httparty'
require "retries"
require 'logger'
require 'ostruct'

class TouringPlansComFeed

  attr_reader :district, :eatery
  def initialize(district, eatery) #Each park seperately lists its eateries, but all the resorts are in one feed.
    @district = district
    @eatery = eatery
  end

  include HTTParty
  # debug_output $stderr
  base_uri 'touringplans.com'
  default_params :output => 'json'
  format :json
  
  # This is the starting point
  def district_name_and_permalink_hash
    districts = {
      "Magic Kingdom"=>"/magic-kingdom/dining.json", 
      "Epcot"=>"/epcot/dining.json", 
      "Disney's Hollywood Studios"=>"/hollywood-studios/dining.json", 
      "Animal Kingdom"=>"/animal-kingdom/dining.json",
      "Typhoon Lagoon"=>"/typhoon-lagoon/dining.json",
      "Blizzard Beach"=>"/blizzard-beach/dining.json",
      'Downtown Disney' => "/walt-disney-world/downtown-disney-dining",
      "resorts" => "/walt-disney-world/resort-dining.json"
    } 
    
  end
    
  #fetch a listing of all eateries in district
  def fetch_listing
    districts = district_name_and_permalink_hash 
    district_permalink = districts.fetch(district.name) { 
      raise "Whoa, cannot fetch listing,-- #{district.name} --  not a park or general listing of resorts." 
    }

    # Technical:  Class (self) instead of an instance variable is used to access HTTParty params
    @listing = TouringPlansComFeed.get(district_permalink).parsed_response
  end
  
  
  def select_resort_and_its_eateries_from_listing(lodging_districts)
    @resort_name_permalink_and_eateries = lodging_districts.select {|x| x['permalink'] == resort_permalink }
    # @resort_eatery_names_and_permalinks = @resort_name_permalink_and_eateries[0]['dinings']
    # return @resort_eatery_names_and_permalinks
    
    # resort_name_permalink_and_eateries = lodging_districts.select {|x| x['permalink'] == resort_permalink }
    # resort_eatery_names_and_permalinks = resort_name_permalink_and_eateries[0]['dinings']
    # return resort_eatery_names_and_permalinks
  end
  
  # --- Eatery Details --- #
  def get_eatery_details_by_permalink
    # http://touringplans.com/walt-disney-world/dining/chuck-wagon.json
    eatery_permalink  = eatery.permalink || ""
    eatery_name       = eatery.name      || eatery_permalink.split("-").join(" ")
    link              = construct_eatery_permalink
    # puts "link: #{link}"
    response = TouringPlansComFeed.get(link)
    case response.code
      when 200
        @eatery = TouringPlansComFeed.get(link).parsed_response
      when 404
        @eatery               = _echo_back_empty_hash
        @eatery["permalink"]  = eatery_permalink
        @eatery["name"]       = eatery_name
      when 500...600
        # puts "ZOMG ERROR #{response.code}"
        @eatery               = _echo_back_empty_hash
        @eatery["permalink"]  = eatery_permalink
        @eatery["name"]       = eatery_name
    end

    @eatery
  end
  
  # --- Menus at TouringPlans.com --- #
  def get_menu_details_by_permalink
    # http://touringplans.com/magic-kingdom/dining/aloha-isle/menus/all-day-menu.json
    # http://touringplans.com/walt-disney-world/dining/boma-flavors-of-africa/menus/breakfast.json
    link = construct_menu_permalink
    @menu = TouringPlansComFeed.get(link).parsed_response
  end
  
  ################# ----- #################
  # private

  def construct_eatery_permalink
    eatery_permalink = []
    eatery_permalink << eatery_permalink_root
    eatery_permalink << eatery.permalink
    "#{eatery_permalink.join('/')}.json"
    
  end
  
  def construct_menu_permalink
    menu_permalink = []
    menu_permalink << eatery_permalink_root
    menu_permalink << eatery.permalink
    menu_permalink << "menus"
    menu_permalink << eatery.menu_type_permalink
    "#{menu_permalink.join('/')}.json"
  end
  

  def eatery_permalink_root
    districts = eatery_permalink_root_hash
    permalink_root = districts.fetch(district.name) { 
      raise "Whoa, cannot fetch listing,-- #{district.name} --  not a park or general listing of resorts." 
    }
  end
  

  def eatery_permalink_root_hash
    districts = {
      "Magic Kingdom"=>"/magic-kingdom/dining", 
      "Epcot"=>"/epcot/dining/", 
      "Disney's Hollywood Studios"=>"/hollywood-studios/dining", 
      "Animal Kingdom"=>"/animal-kingdom/dining",
      "Typhoon Lagoon"=>"/typhoon-lagoon/dining",
      "Blizzard Beach"=>"/blizzard-beach/dining",
      "Resorts" => "/walt-disney-world/dining"
    } 
    
  end
  
  def _echo_back_empty_hash
    {"house_specialties"=>"", 
      "entree_range"=>"", 
      "created_at"=>"", 
      "adult_breakfast_menu_url"=>"", 
      "short_name"=>"", 
      "parking"=>"", 
      "requires_pre_payment"=>false, 
      "opened_on"=>nil, 
      "name"=>"", 
      "dinner_hours"=>"", 
      "counter_value_rating"=>"", 
      "when_to_go"=>"", 
      "counter_quality_rating"=>"", 
      "thumbs_up"=>nil, 
      "permalink"=>"", 
      "cuisine"=>"", 
      "child_lunch_menu_url"=>"", 
      "bar"=>"", 
      "awards"=>"", 
      "overall_rating"=>nil, 
      "kosher_available"=>false, 
      "dress"=>"", 
      "disney_permalink"=>nil, 
      "accepts_tiw"=>false, 
      "updated_at"=>"", 
      "phone_number"=>"", 
      "location_details"=>"", 
      "friendliness_rating"=>nil, 
      "cost_code"=>"", 
      "category_code"=>"", 
      "table_quality_rating"=>nil, 
      "extinct_on"=>nil, 
      "adult_lunch_menu_url"=>"", 
      "adult_dinner_menu_url"=>"", 
      "wine_list"=>"", 
      "table_value_rating"=>nil, 
      "requires_credit_card"=>true, 
      "portion_size"=>"", 
      "child_dinner_menu_url"=>"", 
      "service_rating"=>nil, 
      "lunch_hours"=>"", 
      "code"=>"", 
      "child_breakfast_menu_url"=>"", 
      "breakfast_hours"=>"", 
      "accepts_reservations"=>false}
  end
end
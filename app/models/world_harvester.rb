require 'httparty'
require "retries"
require 'logger'

class WorldHarvester
  attr_accessor :notebook
  
  include HTTParty
  # resort doesn't mean an individual lodge, but wdw or disneyland
  # retreat refers to cruise ships, hotels, villas, and lodges on property of the resort
  ## nb: Each district is subdivided at touringplans.com.  The parks are divided into counter service and table
  # service.  The resort dining is segregated by each lodging location, or retreat.

  base_uri 'touringplans.com'
  default_params :output => 'json'
  format :json
  # --- Parks --- #
  # http://touringplans.com/magic-kingdom/dining.json
  def self.find_park_eateries_list_by_permalink(district_permalink)
    get("/#{district_permalink}/dining.json")
  end
    
  def self.find_park_eateries_list_by_permalink_hash(district_permalink)
    self.find_park_eateries_list_by_permalink(district_permalink).parsed_response
  end
    
  # --- Lodging --- #
  # http://touringplans.com/walt-disney-world/resort-dining.json
  def self.find_list_of_lodging_districts
    get('/walt-disney-world/resort-dining.json').parsed_response
  end

  # http://touringplans.com/walt-disney-world/resort-dining.json
  def self.find_resort_eateries_list_by_permalink(lodging_districts, resort_permalink)
    @resort_name_permalink_and_eateries = lodging_districts.select {|x| x['permalink'] == resort_permalink }
    @resort_eatery_names_and_permalinks = @resort_name_permalink_and_eateries[0]['dinings']
    return @resort_eatery_names_and_permalinks
  end
  
  # --- Eatery Details --- #
  # http://touringplans.com/walt-disney-world/dining/chuck-wagon.json
  def self.find_eatery_by_permalink(permalink)
    @eatery = get("/walt-disney-world/dining/#{permalink}.json").parsed_response
  end
  
  # --- Menus at TouringPlans.com --- #
  # http://touringplans.com/magic-kingdom/dining/aloha-isle/menus/all-day-menu.json
  def self.find_menu_by_permalink(eatery_permalink, menu_type_permalink)
    @menu = get("/magic-kingdom/dining/#{eatery_permalink}/menus/#{menu_type_permalink}.json").parsed_response
    return @menu    
  end
  
end
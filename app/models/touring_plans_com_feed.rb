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
    link = construct_eatery_permalink
    @eatery = TouringPlansComFeed.get(link).parsed_response
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
      "resorts" => "/walt-disney-world/dining"
    } 
    
  end
  
end
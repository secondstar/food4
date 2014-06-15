require 'httparty'
require "retries"
require 'logger'
require_relative './touring_plans_com_feed'

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
  def self.find_park_eateries_list_by_permalink(district_name)
    # get("/#{district_permalink}/dining.json")
    params = {name: district_name}
    district = OpenStruct.new(params)
    eatery = OpenStruct.new(params)
    TouringPlansComFeed.new(district, eatery).fetch_listing
  end
    
    
  # --- Lodging --- #
  # http://touringplans.com/walt-disney-world/resort-dining.json
  def self.find_list_of_lodging_districts
    district = OpenStruct.new(:name => "resorts")
    eatery = OpenStruct.new
    TouringPlansComFeed.new(district, eatery).fetch_listing
  end

  # http://touringplans.com/walt-disney-world/resort-dining.json
  def self.find_resort_eateries_list_by_permalink(resort_permalink)
    lodging_districts = self.find_list_of_lodging_districts
    @resort_name_permalink_and_eateries = lodging_districts.select {|x| x['permalink'] == resort_permalink }
    @resort_eatery_names_and_permalinks = @resort_name_permalink_and_eateries[0]['dinings']
    return @resort_eatery_names_and_permalinks
  end
  
  # --- Eatery Details --- #
  # http://touringplans.com/walt-disney-world/dining/chuck-wagon.json
  def self.find_eatery_by_permalink(district_name, eatery_permalink)
    district = OpenStruct.new(:name => district_name)
    eatery   = OpenStruct.new(:permalink => eatery_permalink, :menu_type_permalink => "")
    @eatery = TouringPlansComFeed.new(district, eatery).get_eatery_details_by_permalink
  end
  
  # --- Menus at TouringPlans.com --- #
  # http://touringplans.com/magic-kingdom/dining/aloha-isle/menus/all-day-menu.json
  def self.find_menu_by_permalink(district_name, eatery_permalink, menu_type_permalink)
    # @menu = get("/magic-kingdom/dining/#{eatery_permalink}/menus/#{menu_type_permalink}.json").parsed_response
    district = OpenStruct.new(:name => district_name)
    eatery   = OpenStruct.new(:permalink => eatery_permalink, :menu_type_permalink => menu_type_permalink)
    TouringPlansComFeed.new(district, eatery).get_menu_details_by_permalink
  end
  
  def self.take_snapshot_review_of
    tp = TouringPlansComFeed.new(target).get_eatery_details_by_permalink
    
  end
end
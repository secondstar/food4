################
require 'httparty'
require 'logger'
require 'ostruct'

class Camera
  attr_accessor :notebook
  
  include HTTParty
  format :json
  
  def initialize(photo_target)
    @photo_target = photo_target
  end
  # keep this a basic point and shoot camera
  # aim the camera at a location, and get as many relevant shots as you can.
  # The question of what to shoot and how many stays with the Photographer.
  
  def shoot_collection
    q = flickr_query
    @photos = []
    @results = Camera.get("https://query.yahooapis.com/v1/public/yql", :query =>  {:q => q, :format =>  'json'})
    results_count = @results['query']['count']
    puts "*************"
    puts "q = #{q}"
    puts "results count = #{results_count}"
    puts "@photo_target.quantity = #{@photo_target.quantity}"
    puts "*************"
    return @photos if results_count == 0
    if results_count == 1
      @photos = [@results['query']['results']['photo']]
    else
      @results['query']['results']['photo'].each do |photo|
        @photos << photo
      end
    end
    return @photos
    
  end
  
  def flickr_query
    query = []
    query << flickr_selection
    query << search_term
    query << "and"
    query << wdw_turf_woe_ids
    # query << "and"
    # query << license
    query << "and"
    query << flickr_key
    query << "and"
    query << sort_type
    "#{query.join(" ")} limit #{@photo_target.quantity}"
  end
  
  def all_of_wdw
    query = []
    query << flickr_selection
    query << "text='Walt Disney World'"
    query << wdw_turf_woe_ids
    query << "and"
    query << flickr_key
    query << "and"
    query << sort_type
    "#{query.join(" ")} limit #{@photo_target.quantity}"
    
  end
  def flickr_selection
    "select * from flickr.photos.search where"
  end
  
  def search_term
    # my_photo_search = @photo_target.search_term.gsub("Disney's", "Disney") #clean up wording
    my_photo_search = @photo_target.search_term.downcase.gsub(/[^[[:word:]]\s]/, '') #flickr search trips up on non-alphanumeric characters.  this leaves spaces and only downcased words.
    my_photo_search = @photo_target.search_term.gsub("resort", "") #because not everyone uses the word 'resort'
    
    ghirardelli soda fountain  chocolate shop
    "text =\"#{my_photo_search}\""
  end
  
  def wdw_turf_woe_ids
    # "woe_id in (SELECT woeid FROM geo.places WHERE text='lake buena vista, FL' or text='bay lake, FL' or text='Windermere, FL' or text='Couples Glen, FL' or text='Lake Reams' or text='Celebration, FL' or text='Bay Hill, FL' or text='Downtown Disney Resort')"
    "woe_id in (SELECT woeid FROM geo.places WHERE text='Walt Disney World')"
  end
  
  def license
    "licence='2'"
  end
  
  def flickr_key
    "api_key = '#{FLICKR_KEY}'"
  end
  
  def quantity_limit
    "limit '#{@photo_target.quantity}'"
  end
  
  def sort_type
    "sort='relevance'"
  end
end
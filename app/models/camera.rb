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

  def shoot_collection
    q = flickr_query
    
    @results = Camera.get("https://query.yahooapis.com/v1/public/yql", :query =>  {:q => q, :format =>  'json'})
    arrayed_query_results = Array(@results['query']['results'])
    puts "number of query_results: #{arrayed_query_results.length}"
    if arrayed_query_results.length == 1
      if @results['query']['results']['photo'].first.length == 2
        @photos = [@results['query']['results']['photo']]
      else
        @photos = @results['query']['results']['photo']
      end
    else
      q = all_of_wdw
      @results = Camera.get("https://query.yahooapis.com/v1/public/yql", :query =>  {:q => q, :format =>  'json'})
      @photos = @results['query']['results']['photo']
    end
    return @photos
    
  end
  
  def flickr_query
    query = []
    query << flickr_selection
    query << search_term
    query << "and"
    query << wdw_turf_woe_ids
    query << "and"
    query << flickr_key
    "#{query.join(" ")}limit #{@photo_target.quantity}"
  end
  
  def all_of_wdw
    query = []
    query << flickr_selection
    query << wdw_turf_woe_ids
    query << "and"
    query << flickr_key
    "#{query.join(" ")} limit #{@photo_target.quantity}"
    
  end
  def flickr_selection
    "select * from flickr.photos.search where"
  end
  
  def search_term
    # my_photo_search = @photo_target.search_term.gsub(/'/, "\\\\'") # original -- clean up wording
    my_photo_search = @photo_target.search_term.gsub("Disney's ", "") #clean up wording
    "text =\"#{my_photo_search}\""
  end
  
  def wdw_turf_woe_ids
    "woe_id in (SELECT woeid FROM geo.places WHERE text='lake buena vista, FL' or text='bay lake, FL' or text='Windermere, FL' or text='Couples Glen, FL' or text='Lake Reams' or text='Celebration, FL' or text='Bay Hill, FL')"
  end
  
  def flickr_key
    "api_key = '#{FLICKR_KEY}'"
  end
  
  def quantity_limit
    "limit #{@photo_target.quantity}"
  end
  
end
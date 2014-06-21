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
    default_search = "SELECT * FROM flickr.photos.search WHERE woe_id in (SELECT woeid FROM geo.places WHERE text='lake buena vista, FL' or text='bay lake, FL' or text='Windermere, FL') and api_key = '#{FLICKR_KEY}' limit #{@photo_target.quantity}"
    
    @results = Camera.get("https://query.yahooapis.com/v1/public/yql", :query =>  {:q => q, :format =>  'json'})
    @photos = @results['query']['results']['photo']
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
  
  def flickr_selection
    "select * from flickr.photos.search"
  end
  
  def search_term
    my_photo_search = @photo_target.search_term.gsub(/'/, "\\\\'") #clean up wording
    "where text ='#{my_photo_search}'"
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
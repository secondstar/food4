require 'httparty'

class Camera
  attr_accessor :notebook
  
  include HTTParty
  
  def initialize(photo_target) #Each park seperately lists its eateries, but all the resorts are in one feed.
    @photo_target = photo_target
  end
  
  
  def shoot_collection
    format :json
    my_photo_search = photo_target.photo_search.gsub(/'/, "\\\\'")
    q = "select * from flickr.photos.search where text ='#{my_photo_search}' and woe_id in (SELECT woeid FROM geo.places WHERE text='lake buena vista, FL' or text='bay lake, FL' or text='Windermere, FL') and api_key = '#{FLICKR_KEY}' limit #{photo_target.quantity}"
    default_search = "SELECT * FROM flickr.photos.search WHERE woe_id in (SELECT woeid FROM geo.places WHERE text='lake buena vista, FL' or text='bay lake, FL' or text='Windermere, FL') and api_key = '#{FLICKR_KEY}' limit #{photo_target.quantity}"
    r = "SELECT * FROM flickr.photos.search WHERE woe_id in (SELECT woeid FROM geo.places WHERE text = 'lake buena vista, FL' or text ='bay lake, FL' or text = 'Windermere, FL') and api_key = '#{FLICKR_KEY}' limit 9"
    
    @results = get("https://query.yahooapis.com/v1/public/yql", :query =>  {:q => q, :format =>  'json'})
    @photos = @results['query']['results']['photo']
    return @photos
    
  end
end
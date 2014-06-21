require 'httparty'
require 'ostruct'

class Photographer
  attr_accessor :notebook
  
  include HTTParty
  format :json
  
  def self.find_photos(photo_search='Walt Disney World', quantity=9)
    params = {search_term: photo_search, quantity: quantity }
    
    photo_target = OpenStruct.new(params)
    Camera.new(photo_target).shoot_collection
  end  
  
  def self.find_district_photos(photo_search='Epcot', quantity=9)
    params = {search_term: photo_search, quantity: quantity }
    
    photo_target = OpenStruct.new(params)
    Camera.new(photo_target).shoot_collection
    
  end
  
end

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
  
  def self.publish_photos(photo_search='Epcot', quantity=9, photogenic_type='District')
    @notebook = Notebook.new(entry_fetcher=Photo.public_method(:most_recent))
    if photogenic_type == 'Eatery'
      photogenic_id = Eatery.find_by_name(photo_search).id
      photos = Photographer.find_photos(photo_search, quantity)
    else
      photogenic_type='District'
      photogenic_id = District.find_by_name(photo_search).id
      photos = Photographer.find_district_photos(photo_search, quantity)
    end
    
    photos.each do |photo|
      url = "https://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}.jpg"
      @photo = @notebook.new_photo(farm: photo['farm'],
        server: photo['server'],
        owner: photo['owner'],
        flickr_id: photo['id'],
        title: photo['title'],
        secret: photo['secret'],
        photogenic_id: photogenic_id,
        photogenic_type: photogenic_type,
        url: url
        )

      @photo.publish
    end
  end
  
  
end

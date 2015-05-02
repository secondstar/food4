require 'httparty'
require 'ostruct'

class Photographer
  # photographer is in charge of where the camera is pointed (search), and when the photo is published.
  # In plain terms he determines what location is shot, how many, and where when they are stored and displayed.
  
  attr_accessor :notebook
  
  include HTTParty
  format :json
  
  def self.find_photos(photo_search='Walt Disney World', quantity='10')
    params = {search_term: photo_search, quantity: quantity.to_s, angle: 'basic' }
    
    photo_target = OpenStruct.new(params)
    photos = Camera.new(photo_target).shoot_collection
    # tagged_photos = []
    # if photos.length < quantity.length
    #   @target.angle = 'tags'
    #   tagged_photos = Camera.new(photo_target).shoot_collection
    # end
    # photos = photos + tagged_photos
  end  
  
  def self.publish_photos(photo_search='Epcot', quantity='10', photogenic_type='District')
    @photo_notebook = Notebook.new(entry_fetcher=Photo.public_method(:most_recent))
    if photogenic_type == 'Eatery'
      @photogenic_notebook = Notebook.new(entry_fetcher=Eatery.public_method(:most_recent))
      
    else
      photogenic_type='District'
      @photogenic_notebook = Notebook.new(entry_fetcher=District.public_method(:most_recent))
    end
    
    remote_photo_collection = Photographer.find_photos(photo_search, quantity.to_s)
    photogenic_id = self._find_id_of_photogenic(photo_search)
    # photogenic_id = @photogenic_notebook.entries.find_by_name(photo_search).id.to_i
    remote_photo_collection.each do |photo|
      url = "https://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}.jpg"
      puts "*** photo *** "
      puts "#{photo}"
      puts "***"
      puts "****  #{url} ***"
      @photo = @photo_notebook.new_photo(farm: photo['farm'],
        server: photo['server'],
        owner: photo['owner'],
        flickr_id: photo['id'],
        title: photo['title'],
        secret: photo['secret'],
        photogenic_id: photogenic_id.to_i,
        photogenic_type: photogenic_type,
        url: url
        )

      @photo.publish
    end
  end
  
  def self.update_all_eatery_photos
    @eatery_notebook = Notebook.new(entry_fetcher=Eatery.public_method(:most_recent))
    eateries = @eatery_notebook.entries    
    eateries.each do |eatery|
      Photographer.publish_photos(photo_search=eatery.name, quantity="10", photogenic_type='Eatery')
    end    
  end

  def self.update_all_park_photos
    @district_notebook = Notebook.new(entry_fetcher=District.public_method(:parks))
    @district_notebook.entries.each do |park|
      # puts "park: #{park.name}"
      Photographer.publish_photos(photo_search= "#{park.name}", quantity='10', photogenic_type='District')   
    end 
  end
  
  def self.update_all_resort_photos
    @district_notebook = Notebook.new(entry_fetcher=District.public_method(:resorts))
    @district_notebook.entries.each do |resort|
      # puts "resort: #{resort.name}"
      Photographer.publish_photos(photo_search= "#{resort.name}", quantity='10', photogenic_type='District')
    end
  end  
  
  def self._find_id_of_photogenic(photogenic_name)
    photogenics_names_with_ids = Hash[@photogenic_notebook.entries.map { |h| [h.name ,h.id.to_i]}]
    photogenic_id = photogenics_names_with_ids[photogenic_name]
  end
end

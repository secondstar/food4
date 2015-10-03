#like photographer.rb
require 'foursquare2'

require 'ostruct'

class FoursquareReaper
  attr_reader :entries
  attr_writer :fsq_review_source

  def initialize(entry_fetcher = FoursquareReview.public_method(:all))
    @entry_fetcher = entry_fetcher
    # @params = params
    # @entries  = @params[:entries]
  end
  
 
  def entries
    _fetch_entries.sort_by{|e| e.name}.reverse.take(10)
  end
  
  def fsq_review_source
    _fsq_review_maker
  end
  
  def new_fsq_review(*args)
    fsq_review_source.call(*args).tap do |review|
      review.foursquare_reaper = self
    end
  end
 
  def add_entry(entry)
    entry.save
  end
  
  def fetch_foursquare_venue(query = "")
    # venue = Foursquare.new.find_review(query)
    venue = FoursquareGuaranteedVenue.find(query)
  end

def _reformat_foursquare_venue_to_foursquare_review(venue)
    review_hash = {foursquare_id: venue.id, name: venue.name, address: venue.location.address, 
      cross_street: venue.location.crossStreet, lat: venue.location.lat, lng: venue.location.lng}

  end
  
  def reap_park(park_name="")
    ## ! needs better testing ##
    
    districts =  fetch_parks(park_name)
    puts "** districts #{districts}"
    districts = Array(districts)
    @harvest = Hash.new
    # harvest_hash = Hash.new
    districts.each do |district|
      puts "-- #{district.name}"
      district_name = district.name
      @harvested_eateries = []
    #   #collect names of eateries per each park
      eatery_names_array = district.eateries.map { |eatery| eatery.name }
    #   # seach for each eatery in 4sq by name
      eatery_names_array.each do |eatery_name|
        puts "==========="
        puts "current_eatery: #{eatery_name}"
        @harvested_eateries << eatery_name
        # foursquare_venue  = fetch_foursquare_venue(eatery_name).first
        foursquare_venue  = fetch_foursquare_venue(eatery_name)
        
        refomatted        = _reformat_foursquare_venue_to_foursquare_review(foursquare_venue.first)
        refomatted[:alt_venues] = foursquare_venue[1].join(", ")
        puts "** new entry #{refomatted}"
        fsq_review        = new_fsq_review(refomatted)
        add_entry(fsq_review)
      end
      @harvest[district_name] = @harvested_eateries
      # harvest_hash[district_name] = harvested_eateries
    end
    @harvest
  end

  def fetch_parks(park_name="")
    parks = District.find_by_name(park_name) || District.all.where(:is_park => true)
  end
  
  def _list_park_names
     parks = District.where(:is_park => true)
     park_names = Array(parks.map { |park| park.name })
  end

  
  private
  
  def _fetch_entries
    @entry_fetcher.()
  end

  def _fsq_review_maker
    @fsq_review_source ||= FoursquareReview.public_method(:new)
  end

end
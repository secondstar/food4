#like photographer.rb
require 'foursquare2'

require 'ostruct'

class FoursquareReaper
  attr_reader :entries
  attr_writer :fsq_review_source

  def initialize(entry_fetcher = FoursquareReview.public_method(:most_recent))
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
  
  def archive(eatery_id, foursquare_review_attrs)
    FoursquareReviewArchiver.new(eatery_id, foursquare_review_attrs).store
  end
  
  def reap_park(park_name="")
    ## ! needs better testing ##
    districts =  fetch_parks(park_name)
    harvest = reap(districts)
    districts
  end
  
  def reap_disney_springs
    districts = fetch_disney_springs
    reap(districts)
  end
  
  def reap_resort(resort_name="")
    districts = fetch_resorts(resort_name)
    reap(districts)
  end

  def reap(districts)
    puts "** districts #{districts}"
    districts = Array(districts)
    # Initialize what will be shown to user at the end of the method
    @harvest = Hash.new
    # loop through given districts
    districts.each do |district|
      puts "-- #{district.name}"
      district_name = district.name
      @harvested_eateries = []
    #   #collect names of eateries per each district
      eatery_ids_and_names = district.eateries.select(:id, :name)
    #   # seach for each eatery in 4sq by name
      eatery_ids_and_names.each do |eatery|
        puts "==========="
        puts "current_eatery: #{eatery.name}"
        @harvested_eateries << eatery.name
        reap_eatery(eatery)
      end
      @harvest[district_name] = @harvested_eateries
      # harvest_hash[district_name] = harvested_eateries
    end
    @harvest
  end
  
  def fetch_parks(park_name="")
    parks = District.select(:name, :id).find_by_name(park_name) || District.select(:id, :name).parks
  end
  
  def fetch_disney_springs
    District.select(:id, :name).disney_springs
  end
  def fetch_resorts(resort_name="")
    resorts = District.select(:id, :name).find_by_name(resort_name) || District.select(:id, :name).resorts
  end
  
  def reap_eatery(eatery_id, eatery_name) # eatery is different than entry, just a reminder
    foursquare_venue  = fetch_foursquare_venue(eatery_name)

    reformatted        = _reformat_foursquare_venue_to_foursquare_review(foursquare_venue.first)
    reformatted[:alt_venues] = foursquare_venue[1].join(", ")
    reformatted[:searched_for] = eatery_name
    puts "** new entry, #{eatery_id} #{reformatted}"
    archive(eatery_id, reformatted)
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
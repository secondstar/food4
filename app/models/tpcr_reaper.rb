require 'logger'
require 'ostruct'

class TpcrReaper

  attr_accessor :notebook

  attr_reader :district, :eatery
  def initialize(district, eatery) #Each park seperately lists its eateries, but all the resorts are in one feed.
    @district = district
    @eatery = eatery
  end
  
  
  def reap_park(clock=DateTime)
    district_id = District.where(name: district.name).first.id
    reviews = WorldHarvester.find_park_eateries_list_by_permalink(district.name)[0]
    reviews.each do |review|
      eatery_permalink = review['permalink']
      review = WorldHarvester.find_eatery_by_permalink(district.name, eatery_permalink)
      params = {name: review['name'], 
        permalink: review['permalink'], 
        created_at: review['created_at'], 
        updated_at: review["updated_at"],
        archived_at: clock.now,
        district_id: district_id
      }
      archive_new_review(params)
    end
  end
  
  def reap_resorts(clock=DateTime)
    lodging_districts = WorldHarvester.find_list_of_lodging_districts
    lodging_districts.each do |resort|
      resort_params = {name: resort['name'], permalink: resort["permalink"], is_park:  false, credit: "touringplans.com"}
      resort_district = find_or_create_parent_district(resort_params)
      # resort_details = District.where(permalink: resort_params['permalink']).first
      puts "resort.id #{resort_district.id}"
      if resort_district.id > 0
        if resort['dinings'].length > 0
          resort['dinings'].each do |eatery|
            puts "#{eatery['name']}: #{eatery['permalink']}"
            params = {name: eatery['name'], 
              permalink: eatery['permalink'], 
              created_at: eatery['created_at'], 
              updated_at: eatery["updated_at"],
              archived_at: clock.now,
              district_id: resort_district.id
            }
            archive_new_review(params)
          end
          
        end
      end
    end
  end
  
  def archive_new_review(params)
    @notebook = Notebook.new(entry_fetcher=TouringPlansComReview.public_method(:most_recent))
    new_review = @notebook.new_tpcr(params)
    new_review.archive

    @review = TouringPlansComReview.where(permalink: new_review['permalink']).last
    @eatery = Eatery.find_or_initialize_by(permalink: new_review[:permalink])
    if @eatery.name.blank?
      puts "params are #{params}"
      @eatery.name = new_review['name']
      @eatery.district_id = new_review['district_id']
      @eatery.publish
    end
    @snapshot = @review.snapshots.create!(:review_permalink => @review.permalink, :eatery => @eatery)
    return @snapshot
  end
  
  def find_or_create_parent_district(params)
    District.find_or_create_by(permalink: params[:permalink]) do |district| # test if resort district already exists
      district.name = params[:name]
      district.is_park = params[:is_park]
      district.credit = params[:credit]       
      if district.publish
        puts "Saved #{district.name}"
      end
    end
    return District.where(permalink: params[:permalink]).first
  end
  
end
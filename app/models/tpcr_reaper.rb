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
    review_types = WorldHarvester.find_park_eateries_list_by_permalink(district.name)
    # there are two review_types, counter service and sit-down
    review_types.each do |review_type|
      puts "***** review_type #{review_type} ****"
      review_type.each do |review|
        puts "***** review #{review} ****"
        eatery_permalink = review['permalink']
        review = WorldHarvester.find_eatery_by_permalink(district.name, eatery_permalink)
        params = review
        params = params.merge({district_id: district_id})
        archive_new_review(params)        
      end
    end
  end
  
  def reap_downtown_disney(clock=DateTime)
    district_id = District.where(name: district.name).first.id
    review_types = WorldHarvester.find_downtown_disney_list
    review_types.each do |review_type|
      puts "***** review_type #{review_type[0].to_s} ****"
      puts review_type[1]
      unless review_type[1].to_s.length == 0
        review_type[1].each do |review|
        review_params = {name: review['name'], permalink: review["permalink"], cuisine:  review["cuisine"],
          table_quality_rating: review["table_quality_rating"], counter_quality_rating: review["counter_quality_rating"]}
          puts review_params
          params = review_params.merge({district_id: district_id})
          archive_new_review(params)        
        end
      end
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
          resort['dinings'].each do |review|
            puts "review name: #{review['name']}, review permalink: #{review['permalink']}, district.name: #{district.name}"
            review = WorldHarvester.find_eatery_by_permalink(district.name, review['permalink'])
            puts"********** review:"
            puts review
            # params = review.attributes
            params = review.merge({district_id: resort_district.id})
            archive_new_review(params)
          end
          
        end
      end
    end
  end
  
  def archive_new_review(params)
    # archive the remote data
    # find or create the eatery
    # create the snapshot
    @tpcr_notebook = Notebook.new(entry_fetcher=TouringPlansComReview.public_method(:most_recent))
    new_review = @tpcr_notebook.new_tpcr(params)
    new_review.archive

    @eatery_notebook = Notebook.new
    @eatery = @eatery_notebook.find_or_initialize_eatery(permalink: new_review[:permalink])
    @eatery.name = new_review['name']
    @eatery.district_id = new_review['district_id']
    @eatery.publish
    @snapshot = new_review.snapshots.create!(:review_permalink => new_review.permalink, :eatery => @eatery)
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
#like photographer.rb
require 'nokogiri'
require 'open-uri'

require 'ostruct'
class DfbReaper
  attr_accessor :notebook
  
  def self.reap_review_names_permalinks(path="/disney-world-restaurants-guide")
    
    params = {path: path, yql_css_parse: 'div.entry-content p a' }
    target = OpenStruct.new(params)
    results = DfbHarvester.new(target).scrape_review_listing_page
    return results
  end
  
  def self.archive_new_review(name="Aloha Isle", permalink="aloha-isle")
    dnra = DfbNewReviewArchiver.new(review_name: name, permalink: permalink)
    dnra.store
  end
  
  def self.publish_snapshot(snapshot_attributes)
    puts "snapshot attributes #{snapshot_attributes}"
    snapshot_params = {review_type: "DisneyfoodblogComReview", 
      review_id: snapshot_attributes["id"],
      review_permalink: snapshot_attributes["permalink"],
      eatery_id: snapshot_attributes["eatery_id"],
      review_permalink_is_different_than_eatery_permalink: review_permalink_is_different_than_eatery_permalink = snapshot_attributes['permalink'] != snapshot_attributes['eatery_permalink']
    }
    @snapshot_notebook = Notebook.new(entry_fetcher=Snapshot.public_method(:most_recent))
    snapshot = @snapshot_notebook.new_snapshot(snapshot_params)
    snapshot.publish
  end
  
  def self.update_all_reviews
    dfb_reviews = self.reap_review_names_permalinks[0]
    # # Scraping these are painful. Maybe later.
    dfb_reviews_to_skip = ["2010 09 30 First Look Epcots New Karamell Kuche", "2013 01 15 Review Epcots Les Halles Bakery", "2013 09 04 First Look Starbucks Opens At Epcots Fountain View Cafe", "2013 05 29 First Look Lartisan Des Glaces Sorbet And Ice Cream Shop In Epcots France Is Open See Full Menu And Photos Here", "Disney Bar And Lounge Menu", "Team Spirits Pool Bar", "Amc Dine In Theater", "2014 01 21 News And Review The Smokehouse At House Of Blues Opens In Downtown Disney", "Splitsville Luxury Lanes", "Columbia Harbour House", "Columbia Harbor House", "Pecos Bills Tall Tale Inn And Cafe"]
    dfb_reviews_to_skip.each do |skipped_dfb_review|
      puts "deleting skipped_dfb_review #{skipped_dfb_review}" 
      dfb_reviews.delete(skipped_dfb_review)
    end
    dfb_reviews = self.add_unlisted_reviews(dfb_reviews)
    
    dfb_reviews.each {|key, value| self.archive_new_review(name= key, permalink= value )}
  end
  
  def self.add_unlisted_reviews(dfb_reviews)
    results = dfb_reviews.merge({"Hollywood Scoops" => "hollywood-scoops", "Dinosaur Gertie’s Ice Cream of Extinction" => "dinosaur-gerties-ice-cream-of-extinction", "Oasis Canteen" => "oasis-canteen", "Anaheim Produce" => "anaheim-produce", "KRNR Rock Station" => "krnr-rock-station", "Peevy’s Polar Pipeline" => "peevys-polar-pipeline", "Sweet Spells" => "sweet-spells", "Avalunch" => "avalunch", "Cooling Hut" => "cooling-hut", "Frostbite Freddy's" => "frostbite-freddys", "Warming Hut" => "warming-hut",
      "Coffee Hut" => "coffee-hut", "Contemporary Grounds" => "contemporary-grounds", 
      "Meadow Snack Bar" => "meadow-snack-bar",
      "Chuck Wagon" => "chuck-wagon", "Garden View Lounge Afternoon Tea" => "garden-view-tea-room",
      "Scat Cats Club" => "scat-cats-club", "Turf Club Lounge" => "turf-club-lounge", 
      "Java Bar" => "java-bar", "Splash Terrace" => "splash-terrace"
      })
    
  end
  
  def self.scan_review_details(permalink="aloha-isle")
    params = {path: "#{permalink}", yql_css_parse: '#primary .entry-content p' }
    target = OpenStruct.new(params)
    results = DfbHarvester.new(target).scan_review_details
  end

  def self.archive_dfb_review_addendums(path='aloha-isle', 
      yql_css_parse = 'div.entry-content', snapshot_id = Snapshot.last.id)
      
    params = {path: path, yql_css_parse: yql_css_parse }
    target = OpenStruct.new(params)
    addendums = DfbHarvester.new(target).scan_for_addendums
    @notebook = Notebook.new(entry_fetcher=Addendum.public_method(:most_recent))
    addendums.each do |addendum|
      addendum_params = addendum.merge({:portrayal_id=> snapshot_id, :portrayal_type=>"Snapshot"})
      puts "addendum_params #{addendum_params}\n\n"
      a = @notebook.new_addendum(addendum_params)
      a.archive
    end
    
    # a_params = {"source"=>"http://www.disneyfoodblog.com/aloha-isle/", "href"=>"http://www.disneyfoodblog.com/main-street-ice-cream-parlor/", "description"=>"Main Street Ice Cream Parlor", "category"=>"affinity", :portrayal_id=> snapshot_id, :portrayal_type=>"Snapshot"}
    # a = @notebook.new_addendum(a_params)
    # a.archive
    # return a
  end
end
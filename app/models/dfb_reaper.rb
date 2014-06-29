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
    # nb: the permalink usually used is pulled from reap_review_names_permalinks.  To match, use DfbBridge.
    #steps:
    # 1) cache remote data
    # 2) determine if eatery matches
    # 3) create snapshot
    #     a) link snapshot if matches
    #     b) set eatery id to 0 if doesn't match
    params = {name: name, permalink: permalink}
    target = OpenStruct.new(params)
    puts "**************************** target #{target} ************************"
    
    @dfb_notebook = Notebook.new(entry_fetcher=DisneyfoodblogComReview.public_method(:most_recent))
    scanned_in_review = self.scan_review_details(permalink)[0]
    return if scanned_in_review.blank? # review exists in index, but not really on remote site
    params = {name: name, permalink: permalink}.merge(scanned_in_review)
    dfb_review = @dfb_notebook.new_dfb_review(params)
    dfb_review.archive
    # set up eatery_permalink and eatery_id
    @notebook = THE_NOTEBOOK 
    eatery_permalink = DfbBridge.new(target).get_eatery_permalink
    eatery = @notebook.entries.find_by_permalink(eatery_permalink)
    eatery.to_s.blank? ? eatery_id = 0 : eatery_id = eatery.id
    # set up snapshot
    snapshot_attributes = dfb_review.attributes
    snapshot_attributes = snapshot_attributes.merge("eatery_permalink" => eatery_permalink, "eatery_id" => eatery_id)
    self.publish_snapshot(snapshot_attributes)
  end
  
  def self.publish_snapshot(snapshot_attributes)
    
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
    dfb_reviews_to_skip = ["2013 05 29 First Look Lartisan Des Glaces Sorbet And Ice Cream Shop In Epcots France Is Open See Full Menu And Photos Here", "Disney Bar And Lounge Menu", "Team Spirits Pool Bar", "Amc Dine In Theater", "2014 01 21 News And Review The Smokehouse At House Of Blues Opens In Downtown Disney", "Splitsville Luxury Lanes"]
    dfb_reviews_to_skip.each do |skipped_dfb_review|
      puts "deleting skipped_dfb_review #{skipped_dfb_review}" 
      dfb_reviews.delete(skipped_dfb_review)
    end
    dfb_reviews.each {|key, value| self.archive_new_review(name= key, permalink= value )}
  end
  
  def self.scan_review_details(permalink="aloha-isle")
    params = {path: "/#{permalink}", yql_css_parse: '#primary .entry-content p' }
    target = OpenStruct.new(params)
    results = DfbHarvester.new(target).scan_review_details
  end

  
end
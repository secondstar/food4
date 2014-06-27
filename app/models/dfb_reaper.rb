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
    @eatery = Eatery.find_by_permalink(permalink)
    return if @eatery.blank? # currently only add additional info to a review we have in system

    @notebook = Notebook.new(entry_fetcher=DisneyfoodblogComReview.public_method(:most_recent))
    scanned_in_review = self.scan_review_details(permalink)[0]
    return if scanned_in_review.blank?
    params = {name: name, permalink: permalink}.merge(scanned_in_review)
    dfb_review = @notebook.new_dfb_review(params)
    dfb_review.archive
    self.publish_snapshot(dfb_review)
  end
  
  def self.publish_snapshot(dfb_review)
    unless Eatery.find_by_permalink(dfb_review.permalink).blank?
      snapshot_params = {review_type: "DisneyfoodblogComReview", 
        review_id: dfb_review.id, 
        review_permalink: dfb_review.permalink,
        eatery_id: Eatery.find_by_permalink(dfb_review.permalink).id,
        review_permalink_is_different_than_eatery_permalink: false
      }
      @snapshot_notebook = Notebook.new(entry_fetcher=Snapshot.public_method(:most_recent))
      snapshot = @snapshot_notebook.new_snapshot(snapshot_params)
      snapshot.publish    
    end
  end
  
  def self.update_all_reviews
    dfb_reviews = self.reap_review_names_permalinks[0]
    dfb_reviews.each {|key, value| self.archive_new_review(name= key, permalink= value )}
  end
  
  def self.scan_review_details(permalink="aloha-isle")
    params = {path: "/#{permalink}", yql_css_parse: '#primary .entry-content p' }
    target = OpenStruct.new(params)
    results = DfbHarvester.new(target).scan_review_details
  end

  
end
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
  
  def self.archive_new_review(eatery_name="Cheshire Cafe", permalink="cheshire-cafe")
    dnra = DfbNewReviewArchiver.new(eatery_name, permalink)
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
    dfb_reviews_to_skip = self.list_reviews_to_skip
    dfb_reviews_to_skip.each do |skipped_dfb_review|
      puts "deleting skipped_dfb_review #{skipped_dfb_review}" 
      dfb_reviews.delete(skipped_dfb_review)
    end
    dfb_reviews = self.add_unlisted_reviews(dfb_reviews)
    
    dfb_reviews.each {|key, value| self.archive_new_review(name= key, permalink= value )}
  end
  
  def self.add_unlisted_reviews(dfb_reviews)
    unlisted = DfbDomainKnowledge.new.i_know_these_links_are_not_listed_on_site

    results = dfb_reviews.merge(unlisted)
    
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
  
  def self.list_reviews_to_skip
    problems = DfbDomainKnowledge.new.i_know_normal_scrape_does_not_work
  end
  
end
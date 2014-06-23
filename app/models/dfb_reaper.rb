#like photographer.rb
require 'nokogiri'
require 'open-uri'

require 'ostruct'
class DfbReaper
  attr_accessor :notebook
  
  def self.reap_review_names_permalinks(url="http://www.disneyfoodblog.com/disney-world-restaurants-guide")
    
    params = {url: url }
    target = OpenStruct.new(params)
    results = DfbHarvester.new(target).scrape_review_listing_page
    return results
  end
  
  def self.archive_new_review(name="Aloha Isle", permalink="aloha-isle")
    @notebook = Notebook.new(entry_fetcher=DisneyfoodblogComReview.public_method(:most_recent))
    dfb_review = @notebook.new_dfb_review(name: name, permalink: permalink)
    dfb_review.archive
  end
  
  def self.update_all_reviews
    dfb_reviews = DfbReaper.reap_eatery_permalinks[0]
    dfb_reviews.each {|key, value| DfbReaper.archive_new_review(name= key, permalink= value )}
      # archive_new_review(name=review)
  end
  
end
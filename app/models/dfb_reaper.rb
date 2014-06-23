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
    @notebook = Notebook.new(entry_fetcher=DisneyfoodblogComReview.public_method(:most_recent))
    dfb_review = @notebook.new_dfb_review(name: name, permalink: permalink)
    dfb_review.archive
  end
  
  def self.update_all_reviews
    dfb_reviews = DfbReaper.reap_eatery_permalinks[0]
    dfb_reviews.each {|key, value| DfbReaper.archive_new_review(name= key, permalink= value )}
      # archive_new_review(name=review)
  end
  
  def self.scan_review_details(permalink="aloha-isle")
    params = {path: "/#{permalink}", yql_css_parse: '#primary .entry-content p' }
    target = OpenStruct.new(params)
    results = DfbHarvester.new(target).scan_review_details
    
  end
  
  def self.dbf_item(service_desc)
     desc = service_desc.to_s.split('</strong>').last
     desc = desc.split('</p>').first
     desc = desc.to_s.lstrip
     title = service_desc.to_s.split('</strong>').first
     title = title.gsub(/.*<strong>/, "")
     title = title.gsub(/:$/, "")
    detail = {title => desc}
    
    return detail
  end
  
end
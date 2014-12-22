# like camera
require 'nokogiri'
require 'open-uri'

class DfbHarvester
  def initialize(target)
    @target = target
  end
  
  attr_accessor :notebook
  
  def scrape_review_listing_page
    doc = Nokogiri::HTML(open(yql_url))
    # return doc
    links = Hash.new
    doc.css("a").each do |link|
      permalink = link['href']
      permalink = permalink.blank? ? "" : permalink.gsub(/.*\.disneyfoodblog.com\//,'')
      permalink = permalink.gsub(/\/$/,'')
      name = link['content'].blank? ? self.get_name_from_dfb_permalink(permalink) : link['content'].gsub(/\W/,' ')
      links.store(name, permalink)
    end
    #Take out the first three because they're kruft.
    bad_keys = links.keys[0..2]
    bad_keys.each {|key| links.delete(key) }
    # puts "links - bad_keys  #{links.length}"
    [links]
    
  end
  
  def scan_for_addendums(doc = Nokogiri::HTML(open(yql_url)))
    results =[]
    # bloggings = scan_for_bloggings
    # puts "yql_url #{yql_url}"
    # puts "doc #{doc}"
    @target.doc = doc
    tips = scan_for_tips(doc)
    bloggings = scan_for_bloggings(doc)
    affinities = scan_for_affinities(doc)
    # affinities = scan_for_affinities
    results = tips + bloggings + affinities
  end

  def scan_for_tips(doc = Nokogiri::HTML(open(yql_url)))
    @target.doc = doc
    @target.trigger = "Important Inf"
    results = DfbReviewScanner.new(@target).find_tips
  end
  
  def scan_for_bloggings(doc = Nokogiri::HTML(open(yql_url)))
    @target.doc = doc
    results = DfbReviewScanner.new(@target).find_bloggings
  end

  def scan_for_affinities(doc = Nokogiri::HTML(open(yql_url)))
    @target.doc = doc
    results = DfbReviewScanner.new(@target).find_affinities
  end
  
  def scan_review_details
    puts "** old @target #{@target}"
    # add_review_permalink_to_target
    # @target.path = "/#{DfbBridge.new(@target).get_review_permalink}"
    # puts "new @target #{@target}"
    # #now that we have the proper path
    eatery_values_hash = DfbReviewDetails.new(target: @target).scan
    results = DfbReviewDetails.swap_title(eatery_values_hash)
    results = [results]
    ## ==========================================
    
  end
  
  def get_name_from_dfb_permalink(permalink)
    return permalink.gsub(/\W/,' ').gsub(/\b\w/) { $&.upcase }
  end
  
  # def add_review_permalink_to_target
  #   params = @target.to_h
  #   review_permalink = params[:path].gsub("/","")
  #   params2 = {review_permalink: review_permalink}
  #   params = params.merge(params2)
  #   @target = OpenStruct.new(params)
  # end
  def yql_url
    yc = DfbYqlCollector.new(@target)
    yc.yql_url
  end
  
  
end
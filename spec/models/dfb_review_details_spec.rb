require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_review_details'
require "ostruct"

describe DfbReviewDetails do
  describe '#scan with golden path' do
    params = {path: "whispering-canyon-cafe", yql_css_parse: 'article .entry-content p' }
    let(:target) { OpenStruct.new(params) }
    subject { DfbReviewDetails.new(target: target).scan }
    
    # it 'works' do
    #   subject.must_equal "someting"
    # end
    
    it 'is a hash' do
      subject.must_be_kind_of Hash
    end
    
    it 'constains a hash with 10 elements' do
      subject.size.must_equal 10
    end
  end
  
  describe '#_delete_bad_keys eatery_values_hash includes bad keys' do
    subject { {"service"=>"Counter-Service", "type_of_food"=>"Quick-service pub fare", "location"=>"Fantasyland, Beauty and the Beast area in <a href=\"http://www.disneyfoodblog.com/magic-kingdom-restaurants/\">Magic Kingdom</a>", "disney_dining_plan"=>"Yes (snacks only)", "tables_in_wonderland"=>"No", "menu"=>"The menu includes pork shanks, chocolate croissants, mixed fruit cups, cinnamon rolls, and LeFou’s Brew (no-sugar added frozen apple juice with a hint of toasted marshmallow, then topped with an all-natural passion fruit-mango foam).", "allears.net"=>"<br>\n<a href=\"http://allears.net/dining/menu/gastons-tavern/all-day\" target=\"_blank\">Gaston’s Tavern Menu (all day)</a>", "reviews"=>"<br>\n<a href=\"http://www.disneyfoodblog.com/2012/12/12/full-review-gastons-tavern-in-new-fantasyland/\" target=\"_blank\">Disney Food Blog Full Review: Gaston’s Tavern in New Fantasyland</a><br>\n<a href=\"http://www.disneyfoodblog.com/2013/09/16/review-mickeys-not-so-scary-halloween-party-treats/\" target=\"_blank\">Disney Food Blog Review: Mickey’s Not-So-Scary Halloween Party Treats</a><br>\n<a href=\"http://www.disneyfoodblog.com/2013/06/12/review-lefous-brew-at-gastons-tavern-in-magic-kingdoms-new-fantasyland/\" target=\"_blank\">Disney Food Blog Review: LeFou’s Brew at Gaston’s Tavern in Magic Kingdom’s New Fantasyland</a>", "important_info"=>"", "famous_dishes"=>"Pork Shank, Cinnamon Roll", "disney_food_blog_posts_mentioning_gaston’s_tavern"=>"<br>\n"} }
    
    # it 'works' do
    #   subject.must_equal "something"
    # end
  end
  
  
end
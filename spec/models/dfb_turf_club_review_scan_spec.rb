require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_turf_club_review_scan'
require "ostruct"

describe DfbTurfClubReviewScan do
  ## !! This is the example spec for all factories of reviews

  let(:initial_scan) { {"update"=>"", "service"=>"Table-Service", 
    "type_of_food"=>"American steaks and sandwiches, and Seafood", 
    "location"=>"Disney’s Saratoga Springs Resort and Spa", 
    "disney_dining_plan"=>"Yes, One Table Service Credit", 
    "tables_in_wonderland"=>"Yes", "menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/saratoga-springs-resort-and-spa/turf-club-bar-and-grill/menus/\" target=\"_blank\">Official Disney Menu</a>", "reviews"=>"<br>\n<a href=\"http://www.disneyfoodblog.com/2010/11/24/review-turf-club-appetizers/\">Disney Food Blog Review: Turf Club Appetizers Review</a><br>\n<a href=\"http://www.disneyfoodblog.com/2014/09/14/review-dinner-at-the-turf-club-bar-and-grill-at-saratoga-springs-resort/\" target=\"_blank\">Disney Food Blog Review: Dinner at The Turf Club Bar and Grill at Saratoga Springs Resort</a>", "important_info"=>"", "famous_dishes"=>"Buffalo chicken wings, Prime Rib, New York Style Cheesecake", "disney_food_blog_posts_mentioning_turf_club_bar_&amp;_grill"=>""} }
    
    subject { DfbTurfClubReviewScan.new(initial_scan) }
    
  describe 'normalize' do
    it 'works' do
      subject.normalize.must_equal "something"
    end
    
    it 'is a hash' do
      subject.normalize.must_be_kind_of Hash
    end
    
    it 'has 10 elements' do
      subject.normalize.size.must_equal 10
    end
  end
end
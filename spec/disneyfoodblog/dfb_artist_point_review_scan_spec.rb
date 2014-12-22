require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/disneyfoodblog/dfb_artist_point_review_scan'
require "ostruct"

describe DfbArtistPointReviewScan do

  let(:initial_scan) { {"service"=>"Table-Service", 
  "type_of_food"=>"American, Northwestern cuisine focus", 
  "location"=>"Disney’s Wilderness Lodge Resort", 
  "disney_dining_plan"=>"Yes, Two Table Service Credits", 
  "tables_in_wonderland"=>"Yes", 
  "menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/wilderness-lodge-resort/artist-point/menus/\" target=\"_blank\">Official Disney Menu</a>", 
  "reviews"=>"<br>\n<a href=\"http://www.disneyfoodblog.com/2012/03/11/review-artist-point-in-disneys-wilderness-lodge/\">Disney Food Blog Review: Artist Point in Disney’s Wilderness Lodge</a><br>\n<a href=\"http://www.disneyfoodblog.com/2011/04/24/wilderness-lodge-artist-point/\">Disney Food Blog Review: Wilderness Lodge’s Artist Point Review</a><br>\n<a href=\"http://www.disneyfoodblog.com/2013/10/16/guest-review-confit-natural-bacon-appetizer-at-wilderness-lodges-artist-point/\" target=\"_blank\">Guest Review: Confit Natural Bacon Appetizer at Wilderness Lodge’s Artist Point</a>", 
  "important_info"=>"", 
  "famous_dishes"=>"Cedar plank-roasted salmon, and Artist Point cobbler: seasonal berries and house-made black raspberry ice cream.", 
  "disney_food_blog_posts_mentioning_artist_point"=>"", 
"for_information_on_other_walt_disney_world_table_service_restaurants,_head_to_our_<a_href=\"http"=>"", 
  "save_money_with_bundles"=>"at <a href=\"http://dfbstore.com\" target=\"_blank\">DFBStore.com</a>. Click below to see our current DEALS!", 
  "18_different_facets_of_disney_dining"=>", then recommends Disney World restaurants that will be perfect for your family!<br>\n<a href=\"http://www.disneyfoodblog.com/restaurant-search/\" target=\"_blank\"><img alt=\"\" class=\"aligncenter size-full wp-image-43472\" height=\"110\" src=\"http://www.disneyfoodblog.com/wp-content/uploads/2011/11/disney_searchtool2.jpg\" title=\"disney_searchtool2\" width=\"250\"></a>", 
  "<a_href=\"http"=>"", "the_disney_food_blog"=>""}  }

    subject { DfbArtistPointReviewScan.new(initial_scan) }

  describe 'normalize' do
    it 'is a hash' do
      subject.normalize.must_be_kind_of Hash
    end

    it 'has 10 elements' do
      subject.normalize.size.must_equal 10
    end

    # key in original hash did not have a 'menu' key
    it 'has an element called menu' do
      subject.normalize["menu"].must_include "Official Disney Menu"
    end
  end
end
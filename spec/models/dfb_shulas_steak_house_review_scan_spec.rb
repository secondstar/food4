require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_shulas_steak_house_review_scan'
require "ostruct"

describe DfbShulasSteakHouseReviewScan do

  let(:initial_scan) { {"service"=>"Table-Service", "type_of_food"=>"American, Steakhouse", "location"=>"Swan &amp; Dolphin Resorts", "disney_dining_plan"=>"No", "tables_in_wonderland"=>"Yes", "restaurant.com_gift_certificate"=>"Get a <a href=\"http://www.dpbolvw.net/click-3728159-10870269\">$25 Gift Certificate for $10 or less</a>", "menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/dolphin-hotel/shula-steak-house/menus/\" target=\"_blank\">Official Disney Menu</a>", "reviews"=>"<br>\n<a href=\"http://www.disneyfoodblog.com/2009/11/17/shulas-steakhouse-review/\">Disney Food Blog Review: Shula’s Steak House Review</a><br>\n<a href=\"http://www.disneyfoodblog.com/2013/04/07/review-shulas-steak-house-at-the-walt-disney-world-dolphin/\" target=\"_blank\">Disney Food Blog Review: Shula’s Steak House at the Walt Disney World Dolphin</a>", "important_info"=>"", "famous_dishes"=>"Many steak cuts, 3-5 pound lobsters, crab cakes, hash browns, apple crips", "disney_food_blog_posts_mentioning_shula’s_steak_house"=>"", "save_money_with_bundles"=>"at <a href=\"http://dfbstore.com\" target=\"_blank\">DFBStore.com</a>. Click below to see our current DEALS!", "18_different_facets_of_disney_dining"=>", then recommends Disney World restaurants that will be perfect for your family!<br>\n<a href=\"http://www.disneyfoodblog.com/restaurant-search/\" target=\"_blank\"><img alt=\"\" class=\"aligncenter size-full wp-image-43472\" height=\"110\" src=\"http://www.disneyfoodblog.com/wp-content/uploads/2011/11/disney_searchtool2.jpg\" title=\"disney_searchtool2\" width=\"250\"></a>", "<a_href=\"http"=>"", "the_disney_food_blog"=>""} }

    subject { DfbShulasSteakHouseReviewScan.new(initial_scan) }

  describe 'normalize' do
    it 'is a hash' do
      subject.normalize.must_be_kind_of Hash
    end

    it 'has 11 elements' do
      subject.normalize.size.must_equal 11
    end

    # key in original hash did not have a 'menu' key
    it 'has an element called menu' do
      subject.normalize["menu"].must_include "Official Disney"
    end
  end
end
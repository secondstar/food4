require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_cool_wash_pizza_review_scan'
require "ostruct"

describe DfbCoolWashPizzaReviewScan do

  let(:initial_scan) { {"note"=>"",
   "service"=>"Counter Service", 
   "type_of_food"=>"American, Pizza", "location"=>"<a href=\"http://www.disneyfoodblog.com/epcot-restaurants/\">Epcot</a>, Future World", 
   "disney_dining_plan"=>"Snacks only", 
   "tables_in_wonderland"=>"No", 
   "menu"=>"<br>\nAllears.net:<br>\n<a href=\"http://allears.net/menu/menu_cwp.htm\" target=\"_blank\">Cool wash Pizza Menu</a>", 
   "important_info"=>"", 
   "famous_dishes"=>"Cheese Pizza, Pepperoni Pizza", 
   "disney_food_blog_posts_mentioning_cool_wash_pizza"=>"", 
   "save_money_with_bundles"=>"at <a href=\"http://dfbstore.com\" target=\"_blank\">DFBStore.com</a>. Click below to see our current DEALS!", 
   "18_different_facets_of_disney_dining"=>", then recommends Disney World restaurants that will be perfect for your family!<br>\n<a href=\"http://www.disneyfoodblog.com/restaurant-search/\" target=\"_blank\"><img alt=\"\" class=\"aligncenter size-full wp-image-43472\" height=\"110\" src=\"http://www.disneyfoodblog.com/wp-content/uploads/2011/11/disney_searchtool2.jpg\" title=\"disney_searchtool2\" width=\"250\"></a>", 
   "<a_href=\"http"=>"", 
   "the_disney_food_blog"=>""} }

    subject { DfbCoolWashPizzaReviewScan.new(initial_scan) }

  describe 'normalize' do
    it 'is a hash' do
      subject.normalize.must_be_kind_of Hash
    end

    it 'has 9 elements' do
      subject.normalize.size.must_equal 9
    end

    # key in original hash did not have a 'menu' key
    it 'has an element called menu' do
      subject.normalize["menu"].must_include "Allears"
    end
  end
end
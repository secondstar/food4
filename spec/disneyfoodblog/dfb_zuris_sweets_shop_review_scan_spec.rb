require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/disneyfoodblog/dfb_zuris_sweets_shop_review_scan'
require "ostruct"

describe DfbZurisSweetsShopReviewScan do

  let(:initial_scan) { {"service"=>"Counter Service", 
    "type_of_food"=>'Sweets, some with an African-spice influence', 
    "location"=>"Harambe Market in Africa, Disney’s Animal Kingdom", 
    "disney_dining_plan"=>"Yes, Snack Credits", 
    "tables_in_wonderland"=>"No", "menu_at_allears.net"=>'<a href="http\://allears.net/dining/menu/zuris-sweets/snacks" target="_blank">Zuri’s Sweets Shop Menu</a>', "reviews"=>'<a href="http://www.disneyfoodblog.com/2015/06/18/first-look-zuris-sweets-shop-and-the-poop-candy-at-disneys-animal-kingdom/" target="_blank">First Look: Zuri’s Sweets Shop — and the Poop Candy! — at Disney’s Animal Kingdom</a>', 
    "menu_at_allears.net" => '<a href="http\://allears.net/dining/menu/zuris-sweets/snacks" target="_blank">Zuri’s Sweets Shop Menu</a>',
    "important_info"=> '<a href="http://allears.net/dining/menu/zuris-sweets/snacks" target="_blank">Zuri’s Sweets Shop Menu</a>', 
"famous_dishes"=>'Monkey Caramel Apple, “Match the Species” Poop Candy', "disney_food_blog_posts_mentioning_zuris_sweets_shop"=>"",
"you_might_also_like"=>'<a href="http://www.disneyfoodblog.com/main-street-confectionery/" target="_blank">Main Street Confectionery</a>, <a href="http://www.disneyfoodblog.com/seashore-sweets/" target="_blank">Seashore Sweets</a>, <a href="http://www.disneyfoodblog.com/harambe-market/" target="_blank">Harambe Market</a>'
} }
    
    subject { DfbZurisSweetsShopReviewScan.new(initial_scan) }
    
  describe 'normalize' do
    # it 'works' do
    #   subject.must_equal "something"
    # end

    it 'is a hash' do
      subject.normalize.must_be_kind_of Hash
    end
    
    it 'has 11 elements' do
      subject.normalize.size.must_equal 11
    end
    
    it 'returns the key named menu' do
      subject.normalize.keys.must_include "menu"
    end
    
  end

  describe '_rename_bad_keys' do
    # it 'works' do
    #   subject._rename_bad_keys.must_equal "something"
    # end
    it 'returns a hash' do
      subject._rename_bad_keys.must_be_kind_of Hash
    end
    
    it 'does not return the key "menu_at_allears.net"' do
      # subject._rename_bad_keys.must_include '<a href="http://allears.net/dining/menu/zuris-sweets/snacks" target="_blank">Zuri’s Sweets Shop Menu</a>'
      subject._rename_bad_keys.wont_include 'menu_at_allears.net'
    end
    
    it 'returns the key named menu' do
      subject.normalize.keys.must_include "menu"
    end
    
  end
end
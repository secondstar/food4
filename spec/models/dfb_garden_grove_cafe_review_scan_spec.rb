require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_garden_grove_cafe_review_scan'
require "ostruct"

describe DfbGardenGroveCafeReviewScan do

  let(:initial_scan) { {"as_of_july_17th,_2013,_dinner_buffets_are_only_held_on_friday_evenings."=>"", 
    "service"=>"Table-Service", 
    "type_of_food"=>"American; Buffet on Friday nights only", 
    "location"=>"Swan &amp; Dolphin Resorts", 
    "disney_dining_plan"=>"No", 
    "tables_in_wonderland"=>"Yes", 
    "restaurant.com_gift_certificate"=>"Get a <a href=\"http://www.dpbolvw.net/click-3728159-10870269\">$25 Gift Certificate for $10 or less</a>", 
    "menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/swan-hotel/garden-grove/menus/breakfast/\" target=\"_blank\">Official Disney Breakfast Menu</a><br>\n<a href=\"https://disneyworld.disney.go.com/dining/swan-hotel/garden-grove/menus/lunch/\" target=\"_blank\">Official Disney Lunch Menu</a><br>\n<a href=\"https://disneyworld.disney.go.com/dining/swan-hotel/garden-grove/menus/dinner/\" target=\"_blank\">Official Disney Dinner Menu</a>", 
    "important_info"=>"", 
    "famous_dishes"=>"Sample the Japanese Breakfast or Almond Crusted French toast for breakfast.", 
    "disney_food_blog_posts_mentioning_garden_grove_cafe"=>""}  }

    subject { DfbGardenGroveCafeReviewScan.new(initial_scan) }

  describe 'normalize' do
    it 'is a hash' do
      subject.normalize.must_be_kind_of Hash
    end

    it 'has 9 elements' do
      subject.normalize.size.must_equal 9
    end

    # key in original hash did not have a 'menu' key
    it 'has an element called menu' do
      subject.normalize["menu"].must_include "Official Disney"
    end
  end
end
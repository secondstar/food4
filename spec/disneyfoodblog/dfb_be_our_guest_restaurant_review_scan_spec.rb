require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/disneyfoodblog/dfb_be_our_guest_restaurant_review_scan'
require "ostruct"

describe DfbBeOurGuestRestaurantReviewScan do

  let(:initial_scan) { {"see_our_<a_href=\"http"=>"", 
    "real_tableware"=>"— no paper and plastic around here. <img alt=\";-)\" class=\"wp-smiley\" src=\"http://www.disneyfoodblog.com/wp-includes/images/smilies/icon_wink.gif\"> Guests who have eaten at <a href=\"http://www.disneyfoodblog.com/disney-world-restaurants-guide/www.disneyfoodblog.com/wolfgang-puck-express/\" target=\"_blank\">Wolfgang Puck Express</a> in Downtown Disney will understand the process here.", 
    "type_of_food"=>"French-Inspired, see below for full menus.", 
    "location"=>"Beast’s Castle in <a href=\"http://www.disneyfoodblog.com/magic-kingdom-restaurants/\">Magic Kingdom</a>", 
    "<a_href=\"http"=>"Yes, dinner only.", 
    "be_our_guest_restaurant_menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/magic-kingdom/be-our-guest-restaurant/menus/lunch/\" target=\"_blank\">Official Disney Lunch Menu</a><br>\n<a href=\"https://disneyworld.disney.go.com/dining/magic-kingdom/be-our-guest-restaurant/menus/dinner/\" target=\"_blank\">Official Disney Dinner Menu</a>", 
    "cracked_door_arch"=>"into the Beast’s Ballroom…",
     "entryway_mosaics"=>", even the floor is tiled with intricate mosaics!", 
     "reviews"=>"<br>\n<a href=\"http://www.disneyfoodblog.com/2012/11/01/guest-review-be-our-guest-restaurant-dinner-at-the-magic-kingdom/\" target=\"_blank\">Guest Review: Be Our Guest Restaurant Dinner at the Magic Kingdom</a><br>\n<a href=\"http://www.disneyfoodblog.com/2012/11/04/guest-review-be-our-guest-restaurant-lunch-in-the-magic-kingdom/\" target=\"_blank\">Guest Review: Be Our Guest Restaurant Lunch in the Magic Kingdom</a><br>\n<a href=\"http://www.disneyfoodblog.com/2012/11/09/guest-review-croque-monsieur-at-magic-kingdoms-be-our-guest-restaurant/\" target=\"_blank\">Guest Review: Croque Monsieur at Magic Kingdom’s Be Our Guest Restaurant</a><br>\n<a href=\"http://www.disneyfoodblog.com/2012/11/20/the-everything-on-the-menu-dinner-review-of-be-our-guest-restaurant-in-disney-world/\" target=\"_blank\">Disney Food Blog The “Everything On the Menu!!” Dinner Review of Be Our Guest Restaurant in Disney World</a><br>\n<a href=\"http://www.disneyfoodblog.com/2013/01/06/review-be-our-guest-restaurant-lunch/\" target=\"_blank\">Disney Food Blog Review: Be Our Guest Restaurant Lunch</a><br>\n<a href=\"http://www.disneyfoodblog.com/2013/05/31/guest-review-new-dish-at-be-our-guest-restaurant-in-disney-worlds-magic-kingdom/\" target=\"_blank\">Guest Review: New Dish at Be Our Guest Restaurant in Disney World’s Magic Kingdom</a><br>\n<a href=\"http://www.disneyfoodblog.com/2013/09/03/guest-review-disney-fairy-tale-wedding-reception-food-and-wedding-cake/\" target=\"_blank\">Guest Review: Disney Fairy Tale Wedding Reception Food and Wedding Cake</a><br>\n<a href=\"http://www.disneyfoodblog.com/2013/10/09/review-halloween-desserts-and-new-dinner-menu-items-at-be-our-guest-restaurant/\" target=\"_blank\">Disney Food Blog Review: Halloween Desserts and New Dinner Menu Items at Be Our Guest Restaurant</a><br>\n<a href=\"http://www.disneyfoodblog.com/2014/04/13/review-fastpass-lunch-at-be-our-guest-restaurant-in-disney-worlds-magic-kingdom/\" target=\"_blank\">Disney Food Blog Review: FastPass+ Lunch at Be Our Guest Restaurant in Disney World’s Magic Kingdom</a><br>\n<a href=\"http://www.disneyfoodblog.com/2014/08/07/guest-review-dinner-at-be-our-guest-restaurant-in-disneys-magic-kingdom/\" target=\"_blank\">Guest Review: Dinner at Be Our Guest Restaurant in Disney’s Magic Kingdom</a>", 
     "important_info"=>"", 
     "famous_dishes"=>"Croque Monsieur; Potato Leek Soup; Grilled Strip Steak", 
     "disney_food_blog_posts_mentioning_be_our_guest"=>"<br>\n", 
     "you_might_also_like"=>"<a href=\"http://www.disneyfoodblog.com/cinderellas-royal-table/\">Cinderella’s Royal Table</a>, 
     <a href=\"http://www.disneyfoodblog.com/akershus-royal-banquet-hall-princess-storybook-restaurant/\">Akershus Royal Banquet Hall — Princess Storybook Restaurant</a>"}  }
  #
    subject { DfbBeOurGuestRestaurantReviewScan.new(initial_scan) }

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
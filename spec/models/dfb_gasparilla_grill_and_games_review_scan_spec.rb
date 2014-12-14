require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_gasparilla_grill_and_games_review_scan'
require "ostruct"

describe DfbGasparillaGrillAndGamesReviewScan do

  let(:initial_scan) { {"service"=>"Counter Service", 
  "type_of_food"=>"American", 
  "location"=>"Disney’s Grand Floridian Resort &amp; Spa", 
  "disney_dining_plan"=>"Yes, Counter Service &amp; Snack items", 
  "tables_in_wonderland"=>"No", 
  "menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/grand-floridian-resort-and-spa/gasparilla-grill-and-games/menus/breakfast/\" target=\"_blank\">Official Disney Breakfast Menu</a><br>\n<a href=\"https://disneyworld.disney.go.com/dining/grand-floridian-resort-and-spa/gasparilla-grill-and-games/menus/lunch/\" target=\"_blank\">Official Disney Lunch Menu</a><br>\n<a href=\"https://disneyworld.disney.go.com/dining/grand-floridian-resort-and-spa/gasparilla-grill-and-games/menus/dinner/\" target=\"_blank\">Official Disney Dinner Menu</a><br>\n<a href=\"https://disneyworld.disney.go.com/dining/grand-floridian-resort-and-spa/gasparilla-island-grill/menus/late-night-dining/\" target=\"_blank\">Official Disney Late Night Dining Menu</a>", 
  "breakfast"=>"A variety of pastry and bread items, waffles, breakfast platters, croissant egg sandwiches, pancakes, sausage and gravy, fruit juices, milk, and a selection of hot and cold beverages.", 
  "lunch_&amp;_dinner"=>"Caesar salad, tossed salad, chili, soup, 16″ and individual pizzas, hamburgers and cheeseburgers, chicken sandwich, chicken nuggets, Cuban panini, ham or turkey sandwich, and create your own salads.", 
  "dessert"=>"Fruit bowl, Rice Krispie treat, brownies, cheesecake, chocolate cake, cookies, apple crumb cake, yogurt parfaits, and carrot cake.", 
  "reviews"=>"<br>\n<a href=\"http://www.disneyfoodblog.com/2012/03/03/guest-review-gasparilla-grill-and-games-at-disneys-grand-floridian-resort/\">Guest Review: Gasparilla Grill and Games at Disney’s Grand Floridian Resort</a><br>\n<a href=\"http://www.disneyfoodblog.com/2011/07/24/review-gasparilla-grill-at-disneys-grand-floridian-resort/\">Disney Food Blog Review: Gasparilla Grill at Disney’s Grand Floridian Resort Review</a><br>\n<a href=\"http://www.disneyfoodblog.com/2013/06/23/review-the-new-gasparilla-island-grill-at-disneys-grand-floridian-resort-and-spa/\" target=\"_blank\">Disney Food Blog Review: The NEW Gasparilla Island Grill at Disney’s Grand Floridian Resort and Spa</a>", 
  "important_info"=>"", 
  "famous_dishes"=>"Mickey waffle platter (breakfast only), Southwestern chicken sandwich, Reuben hot dog", 
  "disney_food_blog_posts_mentioning_gasparilla"=>"nothing found.", 
  "you_might_also_like"=>"Artist’s Palette, <a href=\"http://www.disneyfoodblog.com/disney-world-restaurants-guide/www.disneyfoodblog.com/riverside-mill-food-court/\">Riverside Mill Foodcourt</a>, <a href=\"http://www.disneyfoodblog.com/disney-world-restaurants-guide/www.disneyfoodblog.com/captain-cooks-snack-company/\">Captain Cook’s Snack Company</a>"}   }

    subject { DfbGasparillaGrillAndGamesReviewScan.new(initial_scan) }

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
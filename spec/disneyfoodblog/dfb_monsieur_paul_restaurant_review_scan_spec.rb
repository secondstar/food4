require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/disneyfoodblog/dfb_monsieur_paul_restaurant_review_scan'
require "ostruct"

describe DfbMonsieurPaulRestaurantReviewScan do

  let(:initial_scan) { {"monsieur_paul"=>"– replaces Epcot’s Bistro de Paris in Epcot’s France Pavilion.", "service"=>"Table-Service", "type_of_food"=>"French", "location"=>"<a href=\"http://www.disneyfoodblog.com/epcot-restaurants/\">Epcot</a>, <a href=\"http://www.disneyfoodblog.com/world-showcase-restaurants/\">World Showcase</a>, France Pavilion", "disney_dining_plan"=>"Yes", "tables_in_wonderland"=>"To Be Determined", "menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/epcot/monsieur-paul/menus/\" target=\"_blank\">Official Disney Menu</a>", "reviews_of_bistro_de_paris"=>"<br>\nBecause this restaurant is so new, we’ll share a few of our reviews of the previous Bistro de Paris. Many of the menu items have returned on the <a href=\"http://www.disneyfoodblog.com/2012/12/12/news-monsieur-paul-menu-in-epcots-france/\" target=\"_blank\">Monsieur Paul Menu</a>.", "important_info"=>"", "famous_dishes"=>"French favorites like filet mignon, escargot, duck breast, la barre au chocolat", "disney_food_blog_posts_mentioning_bistro_de_paris"=>"", "you_might_also_like"=>"California Grill, Victoria and Albert’s, <a href=\"http://www.disneyfoodblog.com/coral-reef-restaurant/\">Coral Reef</a>"} }

    subject { DfbMonsieurPaulRestaurantReviewScan.new(initial_scan) }

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
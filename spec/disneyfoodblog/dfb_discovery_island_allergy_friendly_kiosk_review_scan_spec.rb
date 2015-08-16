require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/disneyfoodblog/dfb_discovery_island_allergy_friendly_kiosk_review_scan'
require "ostruct"

describe DfbDiscoveryIslandAllergyFriendlyKioskReviewScan do

  let(:initial_scan) { {
    "please_note" => "The Allergy-Friendly Kiosk is located at the kiosk which was previously known as Discovery Island Ice Cream.",
    "service"=>"Kiosk/Information Booth", 
    "type_of_food"=>"French", 
    "location"=>"Discovery Island, Disney’s Animal Kingdom", 
    "disney_dining_plan"=>"Yes, Some Snack Credits", 
    "tables_in_wonderland"=>"No", 
    "menu"=>"Gluten-free snacks items and other allergy safe foods are available.", 
    "reviews"=>"<br>\nBecause this restaurant is so new, we’ll share a few of our reviews of the previous Bistro de Paris. Many of the menu items have returned on the <a href=\"http://www.disneyfoodblog.com/2012/12/12/news-monsieur-paul-menu-in-epcots-france/\" target=\"_blank\">Monsieur Paul Menu</a>.", 
    "important_info"=>"", 
    "famous_dishes"=>"French favorites like filet mignon, escargot, duck breast, la barre au chocolat",
    "you_might_also_like"=>"<a href='http://www.disneyfoodblog.com/sunshine-seasons/' target='_blank'>Sunshine Seasons</a>"} }

    subject { DfbDiscoveryIslandAllergyFriendlyKioskReviewScan.new(initial_scan) }

  describe 'normalize' do
    # it 'works' do
    #   subject.must_equal "something"
    # end

    it 'is a hash' do
      subject.normalize.must_be_kind_of Hash
    end

    it 'has 10 elements' do
      subject.normalize.size.must_equal 10
    end
    #
    # # key in original hash did not have a 'menu' key
    # it 'has an element called menu' do
    #   subject.normalize["menu"].must_include "Official Disney"
    # end
  end
end
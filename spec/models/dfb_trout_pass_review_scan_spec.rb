require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_be_our_guest_restaurant_review_scan'
require "ostruct"

describe DfbTroutPassReviewScan do

  let(:initial_scan) { {"service"=>"Pool Bar", "type_of_food"=>"Just drinks!", "location"=>"Wilderness Lodge pool, Walt Disney World", "disney_dining_plan"=>"No", "tables_in_wonderland"=>"No", "menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/villas-at-wilderness-lodge/trout-pass-pool-bar/menus/\" target=\"_blank\">Official Disney Menu</a>", "moosehead_and_red_hook"=>".", "important_info"=>"", "disney_food_blog_posts_mentioning_trout_pass"=>"nothing found.", "you_might_also_like"=>"<a href=\"http://www.disneyfoodblog.com/territory-lounge/\" target=\"_blank\">Territory Lounge</a> at Wilderness Lodge, <a href=\"http://www.disneyfoodblog.com/banana-cabana-pool-bar/\" target=\"_blank\">Banana Cabana</a> pool bar at Caribbean Beach, <a href=\"http://www.disneyfoodblog.com/uzima-springs-pool-bar/\" target=\"_blank\">Uzima Springs pool bar</a> at Animal Kingdom Lodge"}   }

    subject { DfbTroutPassReviewScan.new(initial_scan) }

  describe 'normalize' do
    it 'is a hash' do
      subject.normalize.must_be_kind_of Hash
    end

    it 'has 9 elements' do
      subject.normalize.size.must_equal 9
    end

  end
end
# require 'minitest/autorun'
require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_reaper'
require "ostruct"

describe DfbReaper do
  let(:url) { "http://www.disneyfoodblog.com/disney-world-restaurants-guide"}
    
  describe "#reap_review_names_permalinks" do
    subject { DfbReaper.reap_review_names_permalinks }

    it 'is a Enumerable' do
      subject.must_be_kind_of Enumerable
    end

    it "returns 1 result" do
      subject.length.must_equal 1
    end
    
    it 'has the first result as a hash' do
      subject.first.must_be_kind_of Hash
      
    end
    
    it 'lists 228 items in the hash' do
      subject.first.length.must_equal 228
    end

  end


  describe "scan_review_details" do
    let(:permalink) {"aloha-isle"}
    
    subject { DfbReaper.scan_review_details}
    it "works" do
      subject.must_equal [{"service"=>"Counter Service", "type_of_food"=>"Dole Whip, soft-serve ice cream, fruit", "location"=>"Adventureland, Magic Kingdom", "disney_dining_plan"=>"Yes, snack credits", "tables_in_wonderland"=>"No", "menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/magic-kingdom/aloha-isle/menus/\" target=\"_blank\">Official Disney Menu</a>", "important_info"=>"", "famous_dishes"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/magic-kingdom/aloha-isle/menus/\" target=\"_blank\">Official Disney Menu</a>", "mentioned_in"=>"", "reviews"=>""}]
    end
  end

  describe '#archive_new_review' do
    let(:new_review_name) {"The Drop Off Pool Bar"}
    let(:permalink) {"the-drop-off-pool-bar"}
    subject { DfbReaper.archive_new_review(new_review_name, permalink) }
    
    it 'works' do
      subject.must_equal "someting"
    end
  end
end
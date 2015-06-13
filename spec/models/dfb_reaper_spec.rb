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
    
    it 'lists 240 items in the hash' do
      subject.first.length.must_equal 241
    end

  end


  describe "scan_review_details" do
    let(:permalink) {"cheshire-cafe"}
    let(:eatery_name) {"Cheshire Cafe"}

    subject { DfbReaper.scan_review_details(permalink)}
    it "is one element in an array" do
      subject.size.must_equal 1
    end
    
    it 'has a hash as the first element' do
      subject[0].must_be_kind_of Hash
    end
    
    it 'has a hash with 11 elements' do
      subject[0].length.must_equal 12
    end
  end

  describe '#archive_new_review' do
    let(:new_review_name) {"The Drop Off Pool Bar"}
    let(:permalink) {"the-drop-off-pool-bar"}
    subject { DfbReaper.archive_new_review(new_review_name, permalink) }
    
    # it 'works' do
    #   subject.must_equal "something"
    # end
    
    it 'is an Array' do
      subject.must_be_kind_of Array
    end
    
    it 'is an Array that contains a Hash' do
      subject.first.must_be_kind_of Hash
    end
    
    it 'has 4 elements in in the first Hash' do
      subject.first.length.must_equal 4
    end
  end
  
  describe '#list_reviews_to_skip' do
    subject { DfbReaper.list_reviews_to_skip }
    
    it 'is an Array' do
      subject.must_be_kind_of Array
    end


    it 'has at least one element' do
      subject.size.must_be :>=, 1
    end
  end
end
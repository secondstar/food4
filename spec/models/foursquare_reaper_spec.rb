# require 'minitest/autorun'
require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/foursquare_reaper'
require "ostruct"

describe FoursquareReaper do
  let(:entries) { [] }
  subject { FoursquareReaper.new(->{entries}) }
  

  it "has no entries" do
    subject.entries.must_be_empty
  end
  
  describe "#new_fsq_review" do
    before do
      @new_foursquare_review = OpenStruct.new
      subject.fsq_review_source = ->{ @new_foursquare_review }
    end
 
    it "should return a new fsq_review" do
      subject.new_fsq_review.must_equal @new_foursquare_review
    end

    it "should set the foursquare_review's reaper reference to itself" do
      subject.new_fsq_review.foursquare_reaper.must_equal subject
    end

    it "should accept an attribute hash on behalf of the fsq_review_maker" do
      fsq_review_maker = MiniTest::Mock.new
      fsq_review_maker.expect(:call, @new_foursquare_review, [{:x => 42, :y => 'z'}])
      subject.fsq_review_source = fsq_review_maker
      subject.new_fsq_review(:x => 42, :y => 'z')
      fsq_review_maker.verify
    end
  end
  
  describe "#add_entry" do
    it "should add the entry to the blog" do
      entry = stub!
      mock(entry).save
      subject.add_entry(entry)

    end
  end
  
  # describe "#collect_review" do
  #   subject { FoursquareReaper.new.collect_review }
  #
  #   it 'is a Enumerable' do
  #     subject.must_be_kind_of Enumerable
  #   end
  #
  #   it "returns 1 result" do
  #     subject.length.must_equal 1
  #   end
  #
  #   it 'has the first result as a hash' do
  #     subject.first.must_be_kind_of Hash
  #
  #   end
  #
  #   it 'lists 242 items in the hash' do
  #     subject.first.length.must_equal 246
  #   end
  #
  # end
  #
  # describe "#scan_review_details" do
  #   let(:permalink) {"cheshire-cafe"}
  #   let(:eatery_name) {"Cheshire Cafe"}
  #
  #   subject { DfbReaper.scan_review_details(permalink)}
  #   it "is one element in an array" do
  #     subject.size.must_equal 1
  #   end
  #
  #   it 'has a hash as the first element' do
  #     subject[0].must_be_kind_of Hash
  #   end
  #
  #   it 'has a hash with 11 elements' do
  #     subject[0].length.must_equal 12
  #   end
  # end
  #
  # describe '#archive_new_review' do
  #   let(:new_review_name) {"The Drop Off Pool Bar"}
  #   let(:permalink) {"the-drop-off-pool-bar"}
  #   subject { DfbReaper.archive_new_review(new_review_name, permalink) }
  #
  #   # it 'works' do
  #   #   subject.must_equal "something"
  #   # end
  #
  #   it 'is an Array' do
  #     subject.must_be_kind_of Array
  #   end
  #
  #   it 'is an Array that contains a Hash' do
  #     subject.first.must_be_kind_of Hash
  #   end
  #
  #   it 'has 4 elements in in the first Hash' do
  #     subject.first.length.must_equal 4
  #   end
  # end
  
  # describe '#list_reviews_to_skip' do
  #   subject { DfbReaper.list_reviews_to_skip }
  #
  #   it 'is an Array' do
  #     subject.must_be_kind_of Array
  #   end
  #
  #
  #   it 'has at least one element' do
  #     subject.size.must_be :>=, 1
  #   end
  # end
end
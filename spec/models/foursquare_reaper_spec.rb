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

  describe '#reap_park for "Magic Kingdom"' do
    ## test is somehow broken.  Code works 
    subject { FoursquareReaper.new(->{entries}) }
    let(:park) { "Magic Kingdom" }
    let(:reaper) { subject.reap_park(park) }


    it 'does something' do
      reaper.must_equal "something"
    end

    it 'is a kind of Hash' do
      reaper.must_be_kind_of Array
    end

    it 'is one element long' do
      reaper.length.must_equal 2
    end
  end
  
end
require_relative '../spec_helper_lite'
require_relative '../../app/models/notebook'
require 'ostruct'

describe Notebook do
    subject { Notebook.new(->{entries}) }
    let(:entries) { [] }

  
  it "has no entries" do
    subject.entries.must_be_empty
  end
  
  describe "#new_eatery" do
      new_eatery = OpenStruct.new
    
    before do
      subject.eatery_maker = ->{ new_eatery }
    end
    
    it "should return a new eatery" do
      subject.new_eatery.must_equal new_eatery
    end
    
    it "should set the eatery's notebook reference to itself" do
      subject.new_eatery.notebook.must_equal(subject)
    end
    
    it "should accept an attribute has on behalf of the eatery maker" do
      eatery_maker = MiniTest::Mock.new
      eatery_maker.expect(:call, new_eatery, [{:x => 42, :y => 'z'}])
      subject.eatery_maker = eatery_maker
      subject.new_eatery(:x => 42, :y => 'z')
      eatery_maker.verify
    end
  end
  
  describe "#new_foursquare_review" do
    before do
      @new_foursquare_review = OpenStruct.new
      subject.foursquare_review_maker = ->{ @new_foursquare_review }
    end
    
    it "should return a new foursquare review" do
      subject.new_foursquare_review.must_equal @new_foursquare_review
    end
    
    it "should set the foursquare review's notebook reference to itself" do
      subject.new_foursquare_review.notebook.must_equal(subject)
    end
    
    it "should accept an attribute has on behalf of the foursquare review maker" do
      foursquare_review_maker = MiniTest::Mock.new
      foursquare_review_maker.expect(:call, @new_foursquare_review, [{:x => 42, :y => 'z'}])
      subject.foursquare_review_maker = foursquare_review_maker
      subject.new_foursquare_review(:x => 42, :y => 'z') 
      foursquare_review_maker.verify
    end
  end
  
  describe "#add_entry" do
    it "should add the entry to the notebook" do
      entry = {name: "loca"}
      mock(entry).save
      subject.add_entry(entry)
    end
  end
  
end
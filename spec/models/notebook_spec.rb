require 'minitest/autorun'
require_relative '../../app/models/notebook'
require 'ostruct'

describe Notebook do
  before do
    @it = Notebook.new
  end
  
  it "has no entries" do
    @it.entries.must_be_empty
  end
  
  describe "#new_entry" do
    before do
      @new_eatery = OpenStruct.new
      @it.eatery_maker = ->{ @new_eatery }
    end
    
    it "should return a new eatery" do
      @it.new_eatery.must_equal @new_eatery
    end
    
    it "should set the eatery's notebook reference to itself" do
      @it.new_eatery.notebook.must_equal(@it)
    end
    
    it "should accept an attribute has on behalf of the eatery maker" do
      eatery_maker = MiniTest::Mock.new
      eatery_maker.expect(:call, @new_eatery, [{:x => 42, :y => 'z'}])
      @it.eatery_maker = eatery_maker
      @it.new_eatery(:x => 42, :y => 'z')
      eatery_maker.verify
    end
  end
  describe "#add_entry" do
    it "should add the eatery to the notebook" do
      entry = Object.new
      @it.add_entry(entry)
      @it.entries.must_include(entry)
    end
  end
  
end
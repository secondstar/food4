require_relative '../spec_helper_lite'
require_relative '../../app/models/touring_plans_com_review'

describe TouringPlansComReview do
  include SpecHelpers
  before do
    @it = TouringPlansComReview.new(:name => "NAME")
    @ar = @it
    @ar_class = TouringPlansComReview
  end
  

  
  it "should support the reading and writing a notebook reference" do
    notebook = Object.new
    @it.notebook = notebook
    @it.notebook.must_equal notebook
  end
  
  describe "#archive" do
    before do
      @notebook = stub!
      @it.notebook = @notebook
      stub(@ar).valid?{true}
    end
    
    it "should add the review to the notebook" do
      mock(@notebook).add_entry(@it)
      @it.archive
    end
    
    it "should return truty on success" do
      assert(@it.archive)
    end
    
    describe "given an invalid review" do
      before do
        stub(@ar).valid?{false}
      end
      
      it "should not add the review to the notebook" do
        dont_allow(@notebook).add_entry
        @it.archive
      end
      
      it "should return false" do
        refute(@it.archive)
      end
    end
  end
  
  describe "#archived_at" do
    describe "before archiving" do
      it "should be blank" do
        @it.archived_at.must_be_nil
      end
    end
    
    describe "after archiving" do
      before do
        @clock = stub!
        @now = DateTime.parse("2011-09-11T02:56")
        stub(@clock).now(){@now}
        @it.notebook = stub!
        @it.archive(@clock)
      end
      
      it "should be a datetime" do
        assert(@it.archived_at.is_a?(DateTime) || 
               @it.archived_at.is_a?(ActiveSupport::TimeWithZone),
               "archived_at must be a datetime of some kind")
      end
 
      
      
      it "should be the current time" do
        @it.archived_at.must_equal(@now)
      end
    end
  end
end
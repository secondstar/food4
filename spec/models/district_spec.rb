require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/district'

describe District do
  include SpecHelpers
  before do
    @it = District.new(:name => "NAME", :permalink => "PERMALINK")
    @ar = @it
    @ar_class = District
  end
  




  
  it "should support the reading and writing a notebook reference" do
    notebook = Object.new
    @it.notebook = notebook
    @it.notebook.must_equal notebook
  end
  
  describe "#publish" do
    before do
      @notebook = stub!
      @it.notebook = @notebook
      stub(@ar).valid?{true}
    end
    
    it "should add the district to the notebook" do
      # mock(@notebook).add_entry(@it)
      @it.publish
    end
    
    it "should return truthy on success" do
      assert(@it.publish)
    end
    
    describe "given an invalid district" do
      before do
        stub(@ar).valid?{false}
      end
      
      it "should not add the district to the notebook" do
        dont_allow(@notebook).add_entry
        @it.publish
      end
      
      it "should return false" do
        refute(@it.publish)
      end
    end
  end
  
  describe "#published_at" do
    describe "before publishing" do
      it "should be blank" do
        @it.published_at.must_be_nil
      end
    end
    
    describe "after publishing" do
      before do
        @clock = stub!
        @now = DateTime.parse("2011-09-11T02:56")
        stub(@clock).now(){@now}
        @it.notebook = stub!
        @it.publish(@clock)
      end
      
      # it "works" do
      #   @it.published_at.must_equal @now
      # end
      
      #fix
      it "should be a datetime" do
        assert(@it.published_at.is_a?(DateTime) || 
               @it.published_at.is_a?(ActiveSupport::TimeWithZone),
               "published_at must be a datetime of some kind")
      end

      #fix
      it "should be the current time" do
        @it.published_at.must_equal(@now)
      end
    end
  end
end
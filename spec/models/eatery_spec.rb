require 'minitest/autorun'
require_relative '../spec_helper_lite'

  stub_module 'ActiveModel::Conversion'
  stub_module 'ActiveModel::Naming'

require_relative '../../app/models/eatery'

describe Eatery do
  before do
    @it = Eatery.new
  end
  
  it "should support setting attributes in the initializer" do
    it = Eatery.new(:name => "myname", :permalink => "permalinkmothe3r")
    it.name.must_equal "myname"    
    it.permalink.must_equal "permalinkmothe3r"
  end
  
  it "should start with blank attributes" do
    @it.name.must_be_nil
    @it.permalink.must_be_nil
  end
  
  it "should support reading and writing a name" do
    @it.name = "Goofy"
    @it.name.must_equal "Goofy"
  end
  
  it "should support the reading and writing a permalink" do
    @it.permalink = "/columbia-harbour-house"
    @it.permalink.must_equal "/columbia-harbour-house"
  end
  
  it "should support the reading and wr5iting a notebook reference" do
    notebook = Object.new
    @it.notebook = notebook
    @it.notebook.must_equal notebook
  end
  
  describe "#publish" do
    before do
      @notebook = MiniTest::Mock.new
      @it.notebook = @notebook
    end
    
    after do
      @notebook.verify
    end
    
    it "should add the eatery to the notebook" do
      @notebook.expect :add_entry, nil, [@it]
      @it.publish
    end
  end
end
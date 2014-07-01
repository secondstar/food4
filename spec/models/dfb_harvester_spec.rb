require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_harvester'
require "ostruct"

describe DfbHarvester do
  # let(:target) { DfbHarvester.new(:path => "/whispering-canyon-cafe", :yql_css_parse => "#primary .entry-content p")}
  before do
    params = {path: "/whispering-canyon-cafe", yql_css_parse: "#primary .entry-content p"}
    @target = OpenStruct.new(params)
    @it = DfbHarvester.new(@target)
  end

  describe "#scan_for_tips" do
    # subject { DfbHarvester.scan_for_tips }
 
    it "works" do
      # def target.path
      #   "/whispering-canyon-cafeer"
      # end
      # def target.yql_css_parse
      #   "#primary .entry-content p"
      # end
    
      @it.scan_for_tips.must_equal ["You never know what’s going to happen at WCC — servers are on the lookout for ways to have fun with guests.", "Surprising things happen when you ask for Ketchup…", "Try to make a reservation for prime mealtimes. When the restaurant is full is when things are most fun."] 
    end  
    
  end  
end
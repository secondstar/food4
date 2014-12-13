require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_yql_collector'
require "ostruct"

describe DfbYqlCollector do
  describe "#yql_url" do
    params = {path: "whispering-canyon-cafe", yql_css_parse: '#primary .entry-content p' }
    let(:target) { OpenStruct.new(params) }
    subject { DfbYqlCollector.new(target).yql_url }
    it "works" do
      
      subject.must_equal "https://query.yahooapis.com/v1/public/yql?q=SELECT+*+FROM+data.html.cssselect+WHERE+url%3D%27http%3A%2F%2Fwww.disneyfoodblog.com%2Fwhispering-canyon-cafe%27+AND+css%3D%27%23primary+.entry-content+p%27&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    end
    
    it 'is a link to yql' do
      subject.must_match /https:\/\/query.yahooapis.com\/v1\/public\/yql/
    end
    
  end

end
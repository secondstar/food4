require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/foursquare_bridge.rb'
require "ostruct"


describe FoursquareBridge do
  subject { FoursquareBridge.new({:name=>"Cheshire Cafe"}) }
  
  describe '#title' do
    it 'works' do
      subject.title.must_equal "now is the time"
    end
  end
  
  describe '#get_review_name' do
    it 'returns "Cheshire Café" for "Cheshire Cafe"' do
      subject.get_review_name.must_equal "Cheshire Café"
    end
    
  end
  
  describe '#_eatery_to_foursquare_conversion_hash' do
    it 'returns a Hash' do
      subject._eatery_to_foursquare_conversion_hash.must_be_kind_of Hash
    end
    
    it 'has a value of "Cheshire Café" for the key "Cheshire Cafe"' do
      subject._eatery_to_foursquare_conversion_hash["Cheshire Cafe"].must_equal "Cheshire Café"
    end
    
  end
end
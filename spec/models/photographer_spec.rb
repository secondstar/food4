# require 'minitest/autorun'
require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/photographer'

describe Photographer do
  let(:photo_search) { "Typhoon Lagoon lazy river"}
  let(:quantity) { 9 }
  
  subject { Photographer.find_photos(photo_search, quantity) }
    

  it 'is an array' do
    subject.must_be_kind_of Array
  end
  
  it 'returns a hash as the first item of the array' do
    subject.first.must_be_kind_of Hash
  end
  
  it "returns 9 results" do
    subject.length.must_equal 9
  end
  
  describe "search results less than one" do
    let(:photo_search) { "Disney's Fort Wilderness Resort Cabins"}
    let(:quantity) { 9 }
    
    subject { Photographer.find_photos(photo_search, quantity) }
    
    it 'is an array' do
      subject.must_be_kind_of Array
    end
  
    it 'returns a hash as the first item of the array' do
      subject.first.must_be_kind_of Hash
    end
  
    it "returns 1 result" do
      subject.length.must_be_close_to 1,10
      # traits.size.must_be_close_to 1,1
      
    end
    
  end
  
end
# require 'minitest/autorun'
require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/photographer'

describe Photographer do
  let(:photo_search) { "Typhoon Lagoon lazy river"}
  let(:quantity) { 9 }
  
  subject { Photographer.find_photos(photo_search, quantity) }
    
  it "works" do
    subject.must_equal [{"farm"=>"3", "id"=>"2671364193", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"22151340@N02", "secret"=>"7eb7438d20", "server"=>"2184", "title"=>"the lazy river"}, {"farm"=>"4", "id"=>"2573358201", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"29619840@N00", "secret"=>"80f70218be", "server"=>"3165", "title"=>"Typhoon Lagoon"}, {"farm"=>"4", "id"=>"2573361045", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"29619840@N00", "secret"=>"865e1bfc0e", "server"=>"3179", "title"=>"Typhoon Lagoon"}, {"farm"=>"9", "id"=>"8162550546", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"51746586@N06", "secret"=>"327a82ef68", "server"=>"8340", "title"=>"Lilo with Luke at the Water Park"}, {"farm"=>"2", "id"=>"1477040117", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"26782864@N00", "secret"=>"b8a718e592", "server"=>"1327", "title"=>"Lazy River"}, {"farm"=>"8", "id"=>"10188634423", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"85644119@N00", "secret"=>"bac582de0f", "server"=>"7318", "title"=>"Castaway Creek at Typhoon Lagoon"}, {"farm"=>"4", "id"=>"9356352534", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"36226805@N03", "secret"=>"10c6ba2b75", "server"=>"3725", "title"=>"TYPHOON LAGOON"}, {"farm"=>"4", "id"=>"9244113424", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"36226805@N03", "secret"=>"d8b6942d1b", "server"=>"3821", "title"=>"LAZY RIVER"}, {"farm"=>"3", "id"=>"9244103502", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"36226805@N03", "secret"=>"42983d67e7", "server"=>"2872", "title"=>"LAZY RIVER"}]
  end

  it "returns 9 results" do
    subject.length.must_equal 9
  end
  
  describe "search results less than one" do
    let(:photo_search) { "Disney's Fort Wilderness Resort Cabins"}
    let(:quantity) { 9 }
    
    subject { Photographer.find_photos(photo_search, quantity) }
    
    it "works" do
      subject.must_equal "something"
    end
  end
  
end
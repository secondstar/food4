require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/camera'
require 'ostruct'

describe Camera do
  before do
    params = {search_term: "Disney's Port Orleans Resort - French Quarter", quantity: "8", angle:  'basic' }
    photo_target = OpenStruct.new(params)
    @it = Camera.new(photo_target)
  end
    
  describe "#shoot_collection" do
  #   it "works" do
  #     @it.shoot_collection.must_equal [{"farm"=>"8", "id"=>"12657515243", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"10259875@N03", "secret"=>"7ff710a8a4", "server"=>"7441", "title"=>"Alligators Playing a Tune at Disney's Port Orleans French Quarter"}, {"farm"=>"4", "id"=>"14347512894", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"10259875@N03", "secret"=>"c873118519", "server"=>"3892", "title"=>"Disney's Port Orleans French Quarter Lobby"}, {"farm"=>"8", "id"=>"13167759023", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"10259875@N03", "secret"=>"076f97de15", "server"=>"7262", "title"=>"Rooms at Disney's Port Orleans French Quarter (1)"}, {"farm"=>"4", "id"=>"13511895693", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"10259875@N03", "secret"=>"72e8ea1710", "server"=>"3684", "title"=>"Disney's Port Orleans French Quarter:  The Fountain"}, {"farm"=>"8", "id"=>"13167670635", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"10259875@N03", "secret"=>"08d8f61bd5", "server"=>"7432", "title"=>"Rooms at Disney's Port Orleans French Quarter (2)"}, {"farm"=>"4", "id"=>"3372357024", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"36226805@N03", "secret"=>"596da6e16f", "server"=>"3580", "title"=>"PORT ORLEANS FRENCH QUARTER RESORT POOL"}, {"farm"=>"9", "id"=>"8567788442", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"8576770@N05", "secret"=>"46f686dd3c", "server"=>"8372", "title"=>"Port Orleans French Quarter"}, {"farm"=>"7", "id"=>"6011911364", "isfamily"=>"0", "isfriend"=>"0", "ispublic"=>"1", "owner"=>"23322134@N02", "secret"=>"6f00e079b9", "server"=>"6030", "title"=>"Fountain at Beignet Square"}]
  #   end
  end

  it "has exactly 8 items" do
    @it.shoot_collection.length.must_equal 8
  end
  
end

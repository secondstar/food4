class FoursquareReview < ActiveRecord::Base
  validates :name, :presence => true

  attr_accessor :foursquare_reaper
end

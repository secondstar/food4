class FoursquareGuaranteedVenue
  # def initialize(args)
  #
  # end
  
  def self.find(name_query)
    search_result = Foursquare.new.find_review(name_query) || FoursquareMissingVenue.new
  end
end
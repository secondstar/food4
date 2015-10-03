class FoursquareGuaranteedVenue
  # def initialize(args)
  #
  # end
  
  def self.find(name_query)
    search_result_array = Foursquare.new.find_review(name_query)
    missing_venue = FoursquareMissingVenue.new
    search_result = search_result_array.first || FoursquareMissingVenue.new
    search_result_array =[search_result, search_result_array[1]]
  end
end
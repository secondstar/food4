class FoursquareBridge
  #names of the eateries and lodgings on Foursquare do not exactly match touringplans
  # target should be an OpenStruct containing {permalink: "akershus-royal-banquet-hall"}
  attr_reader :target
  
  def initialize(target)
    @target = target
  end
  
  def title
    "now is the time"
  end
  
  def get_review_name
    #enter the name wdwhub knows as the name for the venue and return the name foursquare.com knows
    # "Cheshire Café"
    name = target[:name]
    _eatery_to_foursquare_conversion_hash.fetch(name, name)
  end
  
  def _eatery_to_foursquare_conversion_hash
    conversion_hash =
        {"Cheshire Cafe" => "Cheshire Café"}
  end
end
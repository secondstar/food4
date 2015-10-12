class UpdateFromFoursquare < Thor

  desc "update_parks", "update all of the foursquare reviews in all of the parks"
  def update_parks    
    require "./config/environment"
    say "Updating all park eatery reviews from Foursquare.com…", :blue
    say "This may take a while.", :red

    # setting park_name to "" means all parks
    subject   = FoursquareReaper.new(->{entries})
    park_name =  "" 
    subject.reap_park(park_name)
    
  end

  desc "update_disney_springs", "update all of the foursquare reviews in disney springs"
  def update_disney_springs
    say "Updating all Disney Springs eatery reviews from Foursquare.com…", :blue
    say "This may take a while.", :red
    require "./config/environment"

    # setting park_name to "" means all parks
    subject   = FoursquareReaper.new(->{entries})
    subject.reap_disney_springs
  end

  desc "update_resorts", "update foursquare reviews for all of the resorts"
  def update_resorts
    require "./config/environment"
    say "Updating all resort eatery reviews from Foursquare.com…", :blue
    say "This may take a while.", :red

    # setting park_name to "" means all resorts
    subject   = FoursquareReaper.new(->{entries})
    resort_name =  "" 
    subject.reap_resort(resort_name)
  end

end

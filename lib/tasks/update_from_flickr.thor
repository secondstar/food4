class UpdateFromFlickr < Thor

  desc "eatery_photos", "update photos for all of the eateries"
  def eatery_photos    
    require "./config/environment"
    say "Updating all eatery photos…", :red
    say "This may take a while.", :red
    
    Photographer.update_all_eatery_photos
  end

  desc "park_photos", "update general photos for all of the parks"
  def park_photos
    say "Updating park photos…", :red
    require "./config/environment"
    Photographer.update_all_park_photos
  end

  desc "resort_photos", "update general photos for all of the resorts"
  def resort_photos
    require "./config/environment"
    say "Updating lodging photos…", :red
    Photographer.update_all_resort_photos
  end

end

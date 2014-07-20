class UpdateFromTouringPlans < Thor
  
  desc "magic_kingdom", "update the eateries within Magic Kingdom"
  def magic_kingdom
    require "./config/environment"
    say "Updating Touring Plans Magic Kingdom reviews…", :red
    params = {name: "Magic Kingdom"}
    puts params[:name]
    district = OpenStruct.new(params)
    eatery = OpenStruct.new(params)
    puts district
    TpcrReaper.new(district, eatery).reap_park
  end
  
  desc "parks", "update the eateries in all of the parks"
  def parks
    require "./config/environment"
    say "Updating Touring Plans reviews of the eateries…", :red
    parks = District.parks
    parks.each do |park|
      params = {name: park.name}
      puts params[:name]
      district = OpenStruct.new(params)
      eatery = OpenStruct.new(params)
      puts "**************** #{district.name}"
      TpcrReaper.new(district, eatery).reap_park
    end
  end

  desc "lodgings", "update the eateries in all of the on-site hotels"
  def lodgings
    require "./config/environment"
    say "Updating Touring Plans lodging reviews…", :red
    params = {name: "Resorts"}
    puts params[:name]
    district = OpenStruct.new(params)
    eatery = OpenStruct.new(params)
    puts "**************** #{district.name}"
    TpcrReaper.new(district, eatery).reap_resorts
  end

  desc "downtown_disney", "update the eateries in Downtown Disney"
  def downtown_disney
    require "./config/environment"
    say "Updating Touring Plans Downtown Disney reviews…", :red
      params = {name: "Downtown Disney"}
      puts params[:name]
      district = OpenStruct.new(params)
      eatery = OpenStruct.new(params)
      puts "**************** #{district.name}"
      TpcrReaper.new(district, eatery).reap_downtown_disney
  end
  
  desc "update_all_eateries_with_touringplans_com_reviews", "update eateries to the latest Disney Food Blog snapshot"
  def update_all_eateries_with_touringplans_com_reviews
    require "./config/environment"
    say "Updating eateries to the latest Disney Food Blog review snapshots…", :red
    Eatery.update_all_with_touring_plans_com_reviews
  end
end
class UpdateFromDisneyFoodBlog < Thor
  
  desc "all_reviews", "create new snapshots of all the reviews at WDW"
  def all_reviews
    require "./config/environment"
    say "Creating new snapshots of DFB's reivews…", :red
    DfbReaper.update_all_reviews
  end
  
  desc "update_all_eateries_with_disneyfoodblog_com_reviews", "update eateries to the latest Disney Food Blog snapshot"
  def update_all_eateries_with_disneyfoodblog_com_reviews
    require "./config/environment"
    say "Updating eateries to the latest Disney Food Blog review snapshots…", :red
    Eatery.update_all_with_disneyfoodblog_com_reviews
  end
    
end
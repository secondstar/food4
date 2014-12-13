class DfbTurfClubReviewScan
  def initialize(initial_scan)
    @initial_scan =  initial_scan
  end

  attr_reader :initial_scan
  
  def normalize
    # returns only the pairs that have desired keys
    initial_scan.delete("update")
    initial_scan.delete("disney_food_blog_posts_mentioning_turf_club_bar_&amp;_grill")
    
    return initial_scan
  end
  
end
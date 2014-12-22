class DfbTurfClubReviewScan
  def initialize(initial_scan)
    @initial_scan =  initial_scan
  end

  attr_reader :initial_scan
  
  def normalize
    # returns only the pairs that have desired keys
    initial_scan.delete("update")
    
    return initial_scan
  end
  
end
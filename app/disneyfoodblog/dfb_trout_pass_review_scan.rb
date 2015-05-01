class DfbTroutPassReviewScan
  def initialize(initial_scan)
    @initial_scan =  initial_scan
  end
  
  attr_reader :initial_scan
  
  def normalize
    # returns only the pairs that have desired keys
    delete_bad_keys
    eatery_values_hash = _rename_bad_keys
    return eatery_values_hash
  end
  
  def delete_bad_keys
    bad_keys = %w(moosehead_and_red_hook
    )
    bad_keys.each do |k|
      initial_scan.delete(k)
    end
  end
  
  def _rename_bad_keys
    result = initial_scan
  end
  
end
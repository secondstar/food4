class DfbDiscoveryIslandAllergyFriendlyKioskReviewScan
  def initialize(initial_scan)
    @initial_scan = initial_scan
  end
  
  attr_reader :initial_scan
  
  def normalize
    _delete_bad_keys
    # eatery_values_hash = _rename_bad_keys
    # return eatery_values_hash
    return initial_scan
  end
  
  
  def _delete_bad_keys
    bad_keys = ["please_note" ]
    
    bad_keys.each do |k|
      initial_scan.delete(k)
    end
  end
  
  def _rename_bad_keys
    # Disney Food Blog Posts Mentioning Allergy-Friendly Kiosk  = Disney Food Blog Posts Mentioning Discovery Island Allergy-Friendly Kiosk
    result = Hash[initial_scan.map { |k, v| [k.sub(/\Abe_our_guest_restaurant_menu/, 'menu'), v] }]
  end
  
end
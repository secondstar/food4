class DfbBeOurGuestRestaurantReviewScan
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
    first_bad_key = initial_scan.keys.select { |key| key.match('\Asee_our_<a_href=\"http') }
    first_bad_key = first_bad_key[0]
    bad_keys = [first_bad_key, "real_tableware", "cracked_door_arch", "entryway_mosaics" ]
    
    bad_keys.each do |k|
      initial_scan.delete(k)
    end
  end
  
  def _rename_bad_keys
    # change key     "be_our_guest_restaurant_menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/magic-kingdom/be-our-guest-restaurant/menus/lunch/\" target=\"_blank\">Official Disney Lunch Menu</a><br>\n<a href=\"https://disneyworld.disney.go.com/dining/magic-kingdom/be-our-guest-restaurant/menus/dinner/\" target=\"_blank\">Official Disney Dinner Menu</a>", 
    result = Hash[initial_scan.map { |k, v| [k.sub(/\Abe_our_guest_restaurant_menu/, 'menu'), v] }]
  end
  
end
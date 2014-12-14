class DfbGardenGroveCafeReviewScan
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
    bad_key_1 = initial_scan.keys.select { |key| key.match('\Aas_of_july_17th*') }
    bad_key_1 = bad_key_1[0]
    bad_key_2 = initial_scan.keys.select { |key| key.match('\Arestaurant.com*') }
    bad_key_2 = bad_key_2[0]
    bad_keys = [bad_key_1, bad_key_2 ]
    
    bad_keys.each do |k|
      initial_scan.delete(k)
    end
  end
  
  def _rename_bad_keys
    # change key     "be_our_guest_restaurant_menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/magic-kingdom/be-our-guest-restaurant/menus/lunch/\" target=\"_blank\">Official Disney Lunch Menu</a><br>\n<a href=\"https://disneyworld.disney.go.com/dining/magic-kingdom/be-our-guest-restaurant/menus/dinner/\" target=\"_blank\">Official Disney Dinner Menu</a>", 
    # result = Hash[initial_scan.map { |k, v| [k.sub(/\Abe_our_guest_restaurant_menu/, 'menu'), v] }]
    result = initial_scan
  end
  
end

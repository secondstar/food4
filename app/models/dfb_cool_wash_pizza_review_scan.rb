class DfbCoolWashPizzaReviewScan
  def initialize(initial_scan)
    @initial_scan =  initial_scan
  end
  
  attr_reader :initial_scan
  
  def normalize
    # returns only the pairs that have desired keys
    _delete_bad_keys
    eatery_values_hash = _rename_bad_keys
    return eatery_values_hash
  end
  
  def _delete_bad_keys
    bad_key_1 = initial_scan.keys.select { |key| key.match('\A<a_href*') }
    # bad_key_2 = initial_scan.keys.select { |key| key.match('\Arestaurant.com*') }
    # bad_key_2 = bad_key_2[0]
    bad_keys = ["save_money_with_bundles", "18_different_facets_of_disney_dining", "the_disney_food_blog" ] +
                bad_key_1
    
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

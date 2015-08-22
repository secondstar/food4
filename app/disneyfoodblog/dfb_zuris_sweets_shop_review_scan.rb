class DfbZurisSweetsShopReviewScan
  def initialize(initial_scan)
    @initial_scan = initial_scan
  end
  
  attr_reader :initial_scan
  
  def normalize
    # _delete_bad_keys ## not needed yet
    eatery_values_hash = _rename_bad_keys
    return eatery_values_hash
  end
  
  # def _delete_bad_keys
  #   bad_keys = ["menu_at_allears.net" ]
  #
  #   bad_keys.each do |k|
  #     initial_scan.delete(k)
  #   end
  # end
  
  def _rename_bad_keys
    result = Hash[initial_scan.map { |k, v| [k.sub(/\Amenu_at_allears.net/, 'menu'), v] }]
  end
  
  
end
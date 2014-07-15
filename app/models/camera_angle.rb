class CameraAngle
  def initialize(photo_target)
    @photo_target = photo_target
  end
  
  def choose_angle
    angle = @photo_target.angle
    if angle == 'basic'
      q = self.basic
    elsif angle == 'tags_only'
      q = self.tags_only
    end
    return q
  end
  # provides different search queries for a flickr subject
  def basic
      query = []
      query << flickr_selection
      query << cleaned_text_search_term
      query << "and"
      query << wdw_turf_woe_ids
      query << "and"
      query << flickr_key
      query << "and"
      query << sort_type
      query << limit
      "#{query.join(" ")}"
  end
  
  def tags_only
    query = []
    query << flickr_selection
    query << tagged_search_term
    query << "and"
    query << flickr_key
    query << "and"
    query << sort_type
    "#{query.join(" ")} limit #{@photo_target.quantity}"
    
  end
  # parts of the angles
  def flickr_selection
    "select * from flickr.photos.search where"
  end
  
  def cleaned_text_search_term
    my_photo_search = self.clean_up_search_term
    "text =\"#{my_photo_search}\""
  end
  
  def tagged_search_term
    my_photo_search = self.clean_up_search_term
    
    "tags =\"#{my_photo_search}\""
    
  end
  
  def wdw_turf_woe_ids
    "woe_id in (SELECT woeid FROM geo.places WHERE text='lake buena vista, FL' or text='bay lake, FL' or text='Windermere, FL' or text='Couples Glen, FL' or text='Lake Reams' or text='Celebration, FL' or text='Bay Hill, FL' or text='Downtown Disney Resort')"
  end
  
  def license
    "licence='2'"
  end
  
  def flickr_key
    "api_key = '#{FLICKR_KEY}'"
  end
  
  def quantity_limit
    "limit '#{@photo_target.quantity}'"
  end
  
  def sort_type(sort_kind='relevance')
    "sort='#{sort_kind}'"
  end
  
  def limit
    " limit #{@photo_target.quantity}"
  end
  
  def clean_up_search_term
    my_photo_search = @photo_target.search_term.downcase.gsub(/[^[[:word:]]\s]/, '') #flickr search trips up on non-alphanumeric characters.  this leaves spaces and only downcased words.
    my_photo_search = my_photo_search.gsub("resort ", "").gsub("  ", " ") #because not everyone uses the word 'resort'
  end
end
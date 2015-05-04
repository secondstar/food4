class DfbReviewDetails
  # returns a hash that fits into DisneyfoodblogComReview
  def initialize(args)
    @target =  args[:target]
    yql_url = DfbYqlCollector.new(target).yql_url
    @doc = Nokogiri::HTML(open(yql_url))
  end
  
  attr_accessor :notebook, :target, :doc
  
  def scan
    eatery_values_hash = Hash.new
    return [eatery_values_hash] if doc.css("p").blank? #404 error or no such results page at DFB
    eatery_values_hash.default = ""
    # Get a Nokogiri::HTML:Document for the page we’re interested in...
    doc.css("p").each do |item|
        if item.to_s =~ /<strong>/
          h = Hash.new
          title = _dfb_item(item).first.first.to_s.downcase.tr(" ", "_")
          # strips non-breaking space & whitespace that's leading and trailing 
          title = title.gsub(/\A\p{Space}*|\p{Space}*\z/, '')
          desc = _dfb_item(item).first.last
          h.store(title, desc) 
          eatery_values_hash.store(title, desc) unless _unused_title_attributes.include?(title.to_s)
        end
    end
    # deal with inidividual review quirks
    # ==========================================
    eatery_values_hash = _swap_title(eatery_values_hash)
    eatery_values_hash = _normalize_scan(eatery_values_hash)
    return eatery_values_hash
  end
  
  def _dfb_item(service_desc)
     desc = service_desc.to_s.split('</strong>').last
     desc = desc.split('</p>').first
     desc = desc.to_s.lstrip
     title = service_desc.to_s.split('</strong>').first
     title = title.gsub(/.*<strong>/, "")
     title = title.gsub(/:$/, "").split(":").first
    detail = {title => desc}
    
    return detail
  end
  
  def _swap_title(eatery_values_hash)
    #When scanning review details, the title in the DB doesn't always match the column name
    #posts_mentioning -- the key created varies, so we search for it and replace it
    hash_of_dfb_posts_mentioning_this_eatery = eatery_values_hash.select { |key| key.match('\Adisney_food_blog_posts_mentioning*') }
    
    if hash_of_dfb_posts_mentioning_this_eatery.length > 0
      posts_mentioning = eatery_values_hash.select { |key, value|
         key.match('\Adisney_food_blog_posts_mentioning*') }.first.first
      eatery_values_hash["mentioned_in"] = eatery_values_hash[posts_mentioning]
      eatery_values_hash.delete(posts_mentioning)
    end
    
    #important_info - we know the key, so we swap it out directly
    eatery_values_hash["important_info"] =  
        eatery_values_hash.fetch("important_information",
          eatery_values_hash["important_info"])
    eatery_values_hash.delete("important_information")
    
    #famous_drinks/dishes - we know the key, so we swap it out directly
    eatery_values_hash["famous_dishes"] =
        eatery_values_hash.fetch("famous_drinks/dishes",
          eatery_values_hash["famous_dishes"])
    eatery_values_hash.delete("famous_drinks/dishes")

    #famous_drinks - we know the key, so we swap it out directly
    eatery_values_hash["famous_dishes"] =
        eatery_values_hash.fetch("famous_drinks",
        eatery_values_hash["famous_dishes"])
    eatery_values_hash.delete("famous_drinks")

    #best_eats - we know the key, so we swap it out directly
    eatery_values_hash["famous_dishes"] =
        eatery_values_hash.fetch("best_eats",
        eatery_values_hash["famous_dishes"])
    eatery_values_hash.delete("famous_eats")

    #famous_eats - we know the key, so we swap it out directly
    eatery_values_hash["famous_dishes"] = 
        eatery_values_hash.fetch("famous_eats",
        eatery_values_hash["famous_dishes"])

    eatery_values_hash.delete("best_eats")

    #menus - we know the key, so we swap it out directly
    eatery_values_hash["famous_dishes"] =   
        eatery_values_hash.fetch("menus",
        eatery_values_hash["menu"])
    eatery_values_hash.delete("menus")

    #reviews - we know the key, so we swap it out directly
    eatery_values_hash["reviews"] =
        eatery_values_hash.fetch("review",
        eatery_values_hash["reviews"])
    eatery_values_hash.delete("review")    
    return eatery_values_hash
  end
    
  def _normalize_scan(eatery_values_hash)
    if _permalinks_of_reviews_with_non_standard_format.include?(target.path)
       normalized_details = _delete_bad_keys(eatery_values_hash)
      # this might not be needed
      # class_name = "Dfb" + target.path.to_s.titleize.gsub(" ","").gsub("/","") + "ReviewScan"
      # normalized_details = class_name.constantize.new(eatery_values_hash).normalize
    else
      normalized_details = eatery_values_hash
    end
    
    return normalized_details
  end
  
  def _permalinks_of_reviews_with_non_standard_format
    permalinks = DfbDomainKnowledge.new.i_know_these_links_have_bad_hash_keys
  end
  
  def _delete_bad_keys(eatery_values_hash)
    
    good_keys = ["name", "permalink", "archived_at", "created_at", "updated_at", 
                  "service", "type_of_food", "location", "disney_dining_plan", "tables_in_wonderland",
                  "menu", "important_info", "famous_dishes", "mentioned_in", "reviews",
                  "you_might_also_like", "breakfast_items", "drinks", "special_treats"]

    eatery_values_hash.each do |key, value|
      regexp_phrase = '\A'+ key + '\z' # contains only the key
      matches_to_good_keys_size = good_keys.select {|key| key.match(regexp_phrase) }.length
      eatery_values_hash.delete(key) if matches_to_good_keys_size < 1
    end
  end
  
  def _unused_title_attributes
    ["", "allears.net_menus"]
  end
end
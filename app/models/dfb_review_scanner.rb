class DfbReviewScanner
  def initialize(target)
    params = target
    @target  = OpenStruct.new(params)
  end
  
  attr_accessor :target
  
  def _list_categories_and_paths
      category_hash = {}
      target.doc.css("div.entry-content strong").children.each {
        |i| category  =  i.text.strip.downcase.gsub(/[^\w\s\d]/, '');
        category_path =  i.path;
        category_hash[category] = category_path
      }
      category_hash
  end

  def find_tips
    results =[]
    if _list_categories_and_paths.keys.grep(/important info/).any?
      # strong_containing_important_info = target.doc.css(_list_categories_and_paths["important info"]).first.parent.parent
      # list_of_tips = strong_containing_important_info.parent.css("/ul").css("li").children
      list_of_tips = target.doc.css("ul/li")
      list_of_tips.each do |l|
            tips_params = {}
            tips_params['source'] = "http://www.disneyfoodblog.com/#{target.path}/"
            tips_params['href'] = ""
            tips_params['description'] = l.to_s
            tips_params['category'] = "tips"
            results << tips_params
      end
    end
    #
    # # results = find_meat
    # list_items.each do |l|
    #     tips_params = {}
    #     tips_params['source'] = "http://www.disneyfoodblog.com/#{target.path}/"
    #     tips_params['href'] = ""
    #     tips_params['description'] = l.to_s
    #     tips_params['category'] = "tips"
    #     results << tips_params
    # end
    return results
    
  end
  def find_bloggings
    results =[]
    if _list_categories_and_paths.keys.any? {|k| k.include?("posts mentioning")}
      list_items = target.doc.css(".entry-content li/a")
      list_items.each do |l|
          blogging_params = {}
          blogging_params['source'] = "http://www.disneyfoodblog.com/#{target.path}/"
          blogging_params['href'] = l['href']
          blogging_params['description'] = l.text
          blogging_params['category'] = "blogging"
          results << blogging_params
      end
    end

    return results
    
  end
  
  def find_affinities
    results =[]
    if target.doc.css("div.entry-content strong").last.text == "You Might also Like:"

      links =  target.doc.css("div.entry-content strong").last.parent.css("/a")

      links.each do |l|
        affinity_params = {}
        affinity_params['source'] = "http://www.disneyfoodblog.com/#{target.path}/"
        affinity_params['href'] = l['href']
        affinity_params['description'] = l.text
        affinity_params['category'] = "affinity"
        results << affinity_params
      end      
    end
    return results
  end
end
class DfbReviewScanner
  def initialize(target)
    @target = target
  end
  
  def find_meat
    array_of_paragraphs = []

    @target.doc.css("p").each_with_index {|p| array_of_paragraphs << p.to_s}

    indexed_paragraphs_hash = Hash.new

    array_of_paragraphs.each_with_index {|item, index| indexed_paragraphs_hash[index] = item }

    index_number_of_the_heading_of_section = indexed_paragraphs_hash.select {|k,v| v =~ /<strong>#{@target.trigger}/}.keys.first # gives us the index number of the paragraph of the section we want

    section_headings_index_numbers = indexed_paragraphs_hash.select {|k,v| v =~ /<strong>/}.keys # an array


    index_of_next_section_heading =
       section_headings_index_numbers[section_headings_index_numbers.find_index(index_number_of_the_heading_of_section).to_i + 1]

    # puts "***** array_of_paragraphs #{array_of_paragraphs}"
    result = []#array_of_paragraphs #[]
    puts "***************************************"
    puts "array_of_paragraphs[(index_number_of_the_heading_of_section.to_i + 1)..(index_of_next_section_heading.to_i - 1)]"
    puts "#{array_of_paragraphs[(index_number_of_the_heading_of_section.to_i + 1)..(index_of_next_section_heading.to_i - 1)]}"
    puts "***************************************"
    array_of_paragraphs[(index_number_of_the_heading_of_section.to_i + 1)..(index_of_next_section_heading.to_i - 1)].each do |i|
      result << i.split("p>")[1].gsub("</", "")
    end
    return result
    
  end

  def find_tips
    results =[]
    list_items = find_meat
    # results = find_meat
    list_items.each do |l|
        tips_params = {}
        tips_params['source'] = "http://www.disneyfoodblog.com/#{@target.path}/"
        tips_params['href'] = ""
        tips_params['description'] = l.to_s
        tips_params['category'] = "tips"
        results << tips_params
    end
    return results
    
  end
  def find_bloggings
    results =[]
    list_items = @target.doc.css("ul.noindent li")
    list_items.each do |l|
      if l.css('strong').text.blank?
        blogging_params = {}
        blogging_params['source'] = "http://www.disneyfoodblog.com/#{@target.path}/"
        blogging_params['href'] = l.css("a").first['href']
        blogging_params['description'] = l.css("a").first.text
        blogging_params['category'] = "blogging"
        results << blogging_params
      end
    end
    return results
    
  end
  
  def find_affinities
    results =[]
    if @target.doc.css("ul.noindent li strong").first
      links = @target.doc.css("ul.noindent li strong").first.parent.css("a")
      links.each do |l|
        affinity_params = {}
        affinity_params['source'] = "http://www.disneyfoodblog.com/#{@target.path}/"
        affinity_params['href'] = l['href']
        affinity_params['description'] = l.text
        affinity_params['category'] = "affinity"
        results << affinity_params
      end      
    end
    return results
  end
end
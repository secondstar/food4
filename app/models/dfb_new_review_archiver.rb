class DfbNewReviewArchiver
  
  attr_accessor :notebook
  attr_reader :review_name, :permalink
  
  @notebook = THE_NOTEBOOK 
  
  def initialize(args)
    review_name = args[review_name]
    permalink = args[permalink]
  end
  
  def store
    # nb: the permalink usually used is pulled from reap_review_names_permalinks.  To match, use DfbBridge.
    #steps:
    # 1) cache remote data
    # 2) determine if eatery matches
    # 3) create snapshot
    #     a) link snapshot if matches
    #     b) set eatery id to 0 if doesn't match
    params = {name: name, permalink: permalink}
    target = OpenStruct.new(params)
    # puts "**************************** target #{target} ************************"
    
    @dfb_notebook = Notebook.new(entry_fetcher=DisneyfoodblogComReview.public_method(:most_recent))
    scanned_in_review = self.scan_review_details(permalink)[0]
    return if scanned_in_review.blank? # review exists in index, but not really on remote site
    params = {name: name, permalink: permalink}.merge(scanned_in_review)
    dfb_review = @dfb_notebook.new_dfb_review(params)
    dfb_review.archive
    ## harvest dfb_review addendums    
    # iterate through the collection of addendums (tips, bloggings…)
    
    # create addendums with the dfb_review as the portrayal
    # 
    # set up eatery_permalink and eatery_id
    @notebook = THE_NOTEBOOK 
    eatery_permalink = DfbBridge.new(target).get_eatery_permalink
    puts "eatery_permalink = #{eatery_permalink}"
    eatery = @notebook.entries.find_by_permalink(eatery_permalink)
    puts "eatery = #{eatery}"
    eatery.to_s.blank? ? eatery_id = 0 : eatery_id = eatery.id
    # set up snapshot
    snapshot_attributes = dfb_review.attributes
    snapshot_attributes = snapshot_attributes.merge("eatery_permalink" => eatery_permalink, "eatery_id" => eatery_id)
    @snapshot = self.publish_snapshot(snapshot_attributes)
    puts "\n\n*** #{snapshot_attributes} ***\n\n"
    snapshot_id = dfb_review.snapshots.first.id
    snapshot_review_permalink = dfb_review.snapshots.first.review_permalink

    # connect addendums to snapshot
    self.archive_dfb_review_addendums(path= snapshot_review_permalink,
          yql_css_parse = 'div.entry-content', snapshot_id = snapshot_id)
    
  end
  
end
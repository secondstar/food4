class DfbNewReviewArchiver
  
  attr_accessor :notebook
  
  attr_reader :eatery_name, :permalink, :yql_css_parse, :target
  @notebook = THE_NOTEBOOK 
  
  def initialize(eatery_name, permalink, yql_css_parse="article .entry-content p")
    @eatery_name    =  eatery_name
    @permalink      = permalink
    @yql_css_parse  = yql_css_parse
    @target         = {eatery_name: eatery_name, 
                        permalink: permalink, 
                        yql_css_parse: yql_css_parse,
                        path: yql_css_parse}
  end
  
  def store
    # nb: the permalink usually used is pulled from reap_review_names_permalinks.  To match, use DfbBridge.
    #steps:
    # 1) cache remote data
    # 2) determine if eatery matches
    # 3) create snapshot
    #     a) link snapshot if matches
    #     b) set eatery id to 0 if doesn't match
    
    @dfb_notebook = Notebook.new(entry_fetcher=DisneyfoodblogComReview.public_method(:most_recent))
    # scanned_in_review = self.scan_review_details(permalink)[0]
    return if _scanned_in_review.blank? # review exists in index, but not really on remote site
    params = _merge_model_params_with__scanned_in_review
    dfb_review = @dfb_notebook.new_dfb_review(params)
    dfb_review.archive
    # return
    ## harvest dfb_review addendums    
    # iterate through the collection of addendums (tips, bloggings…)
    
    # create addendums with the dfb_review as the portrayal
    # 
    # set up eatery_permalink and eatery_id
    @notebook = THE_NOTEBOOK 
    eatery_permalink = DfbBridge.new(target).get_eatery_permalink
    puts "eatery_permalink = #{eatery_permalink}"
    eatery = @notebook.entries.find_by_permalink(eatery_permalink)
    puts "eatery = #{eatery.name}"
    eatery.to_s.length == 0 ? eatery_id = 0 : eatery_id = eatery.id
    # set up snapshot
    #  => Snapshot(eatery_id: integer, review_type: string, review_id: integer, review_permalink: text, review_permalink_is_different_than_eatery_permalink: boolean, published_at: datetime) 
    # eatery_id: 676, review_type: "DisneyfoodblogComReview", review_id: 14627, review_permalink: "whispering-canyon-cafe", review_permalink_is_different_than_eatery_permalink: false
    snapshot_attributes = {eatery_id: eatery_id, review_type: "DisneyfoodblogComReview", review_id: dfb_review[:id], review_permalink: dfb_review[:permalink], review_permalink_is_different_than_eatery_permalink: false}
    # return
    @snapshot = publish_snapshot(snapshot_attributes)
    puts "\n\n*** #{snapshot_attributes} ***\n\n"
    snapshot_id = dfb_review.snapshots.first.id
    snapshot_review_permalink = dfb_review.snapshots.first.review_permalink
    
    # connect addendums to snapshot
    DfbReaper.archive_dfb_review_addendums(path= snapshot_review_permalink,
          yql_css_parse = 'div.entry-content', snapshot_id = snapshot_id)
    
  end
  
  def _merge_model_params_with__scanned_in_review
    initial_params = {name: eatery_name, permalink: permalink}
    params = initial_params.merge(_scanned_in_review)
  end

  def _scanned_in_review
    params = {:path=> permalink, :yql_css_parse=>"article .entry-content p"}
    scan_target = OpenStruct.new(params)
    DfbHarvester.new(scan_target).scan_review_details[0]
  end
  
  def publish_snapshot(snapshot_attributes)
    snapshot = snapshot_notebook.new_snapshot(snapshot_attributes)
    snapshot.publish
  end
  
  def snapshot_notebook
    @snapshot_notebook = Notebook.new(entry_fetcher=Snapshot.public_method(:most_recent))
  end
  
  def set_snapshot_attributes(dfb_review_attrs)
    attrs = ["eatery_id", "review_type", "review_id", "review_permalink", "review_permalink_is_different_than_eatery_permalink"]
    dfb_review_attrs
    
    
  end
end
class DfbNewReviewArchiver
  
  attr_accessor :notebook
  
  attr_reader :eatery_name, :permalink, :yql_css_parse, :target
  @notebook = THE_NOTEBOOK 
  
  def initialize(eatery_name, permalink, yql_css_parse=".entry-content")
    @eatery_name    =  eatery_name
    @permalink      = permalink
    @yql_css_parse  = yql_css_parse
    @target         = {eatery_name: eatery_name, 
                        permalink: permalink, 
                        yql_css_parse: yql_css_parse,
                        path: permalink}
  end
  
  def store
    
    review = _scanned_in_review
    return if review.blank? # does the review exists in index, but not really on remote site
    
    _connect_snapshot_to_eatery(
        eatery_id = _get_eatery_id_for_snapshot, 
        dfb_review = archive_scanned_in_review(review))
    _connect_addendums_to_snapshot
    
  end
  
  def _merge_model_params_with__scanned_in_review(review)
    initial_params = {name: eatery_name, permalink: permalink}
    params = initial_params.merge(review)
  end

  def _scanned_in_review
    params = {:path=> permalink, :yql_css_parse=>".entry-content p"}
    scan_target = OpenStruct.new(params)
    DfbHarvester.new(scan_target).scan_review_details[0]
  end
  
  def _publish_snapshot(snapshot_attributes)
    snapshot = snapshot_notebook.new_snapshot(snapshot_attributes)
    snapshot.publish
    snapshot
  end
  
  def snapshot_notebook
    @snapshot_notebook = Notebook.new(entry_fetcher=Snapshot.public_method(:most_recent))
  end
  
  def set_snapshot_attributes(dfb_review_attrs)
    attrs = ["eatery_id", "review_type", "review_id", "review_permalink", "review_permalink_is_different_than_eatery_permalink"]
    dfb_review_attrs
    
    
  end
  
  def archive_scanned_in_review(review)
    dfb_notebook = Notebook.new(entry_fetcher=DisneyfoodblogComReview.public_method(:most_recent))
    params = _merge_model_params_with__scanned_in_review(review)
    dfb_review = dfb_notebook.new_dfb_review(params)
    dfb_review.archive
    dfb_review
  end
  
  def _get_eatery_id_for_snapshot
    @notebook = Notebook.new #Eatery notebook
    eatery_permalink = DfbBridge.new(target).get_eatery_permalink
    puts "eatery_permalink = #{eatery_permalink}"
    # find_by_x is a rails method that @notebook doesn't have.  Foreward a message?
    eatery = @notebook.entries.find_by_permalink(eatery_permalink)
    eatery.to_s.length == 0 ? eatery_id = 0 : eatery_id = eatery.id
    eatery_id
  end
  
  def _connect_snapshot_to_eatery(eatery_id = eatery_id, dfb_review = dfb_review)
    snapshot_attributes = {eatery_id: eatery_id, review_type: "DisneyfoodblogComReview", review_id: dfb_review[:id], review_permalink: dfb_review[:permalink], review_permalink_is_different_than_eatery_permalink: false}
    # return
    @snapshot = _publish_snapshot(snapshot_attributes)
    
  end
  
  def _connect_addendums_to_snapshot(snapshot= @snapshot)
    addendums = DfbReaper.archive_dfb_review_addendums(path= snapshot.review_permalink,
          yql_css_parse = 'div.entry-content', snapshot_id = snapshot.id)
    addendums
  end
end
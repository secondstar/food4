class FoursquareReviewArchiver
  
  attr_reader :eatery_id, :foursquare_review_attrs
  
  def initialize(eatery_id, foursquare_review_attrs)
    @eatery_id                =  eatery_id
    @foursquare_review_attrs  = foursquare_review_attrs
  end
  
  
  def store
    return if foursquare_review_attrs.blank? # does the review exists in index, but not really on remote site
    # return review_attrs
    _connect_snapshot_to_eatery(foursquare_review = archive_scanned_in_review)
    # _connect_snapshot_to_eatery(eatery_id = eatery_id, fsq_review = fsq_review)
    
  end
  

  def _publish_snapshot(snapshot_attributes)
    snapshot = snapshot_notebook.new_snapshot(snapshot_attributes)
    snapshot.publish
    snapshot
  end
  
  def snapshot_notebook
    @snapshot_notebook = Notebook.new(entry_fetcher=Snapshot.public_method(:most_recent))
  end
  
  def set_snapshot_attributes(fsr_review_attrs)
    attrs = ["eatery_id", "review_type", "review_id"]
    fsr_review_attrs
    
    
  end
  
  def archive_scanned_in_review
    @foursquare_review_notebook = Notebook.new(entry_fetcher=FoursquareReview.public_method(:most_recent))
    # return foursquare_review_attrs
    foursquare_review = @foursquare_review_notebook.new_foursquare_review(foursquare_review_attrs)
    foursquare_review.archive
    return foursquare_review
  end
  
  
  def _connect_snapshot_to_eatery(foursquare_review)
    foursquare_review_id = foursquare_review.id.to_i
    snapshot_attributes = {eatery_id: eatery_id, review_type: "FoursquareReview", review_id: foursquare_review_id, review_permalink_is_different_than_eatery_permalink: true}
    # return snapshot_attributes
    @snapshot = _publish_snapshot(snapshot_attributes)
  end
  
  
end
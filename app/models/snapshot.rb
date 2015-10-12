class Snapshot < ActiveRecord::Base
  # This model combines a has_many :through relationship with a a polymorphic join.
  # There is one eatery to many reviews of different types, including touringplans and 
  # Disney Food Blog.  If another review source is found, it can be easily added, polymorphically.
  # The eatery only culls data from the latest of each source, and caches it in its own table.
  belongs_to :eatery
  belongs_to :review, polymorphic: true
  has_many :addendums, as: :portrayal  

  attr_accessor :notebook

  def self.most_recent
    last
  end
  
  def self.touringplans
    # last
    where(review_type: "TouringPlansComReview").order("published_at DESC")
  end
  def self.dfb
    # last
    where(review_type: "DisneyfoodblogComReview").order("published_at DESC")
  end
  
  def self.foursquare
    where(review_type: "FoursquareReview").order("published_at DESC")
  end
  
  def publish(clock=DateTime)
    return false unless valid?
    self.published_at = clock.now
    notebook.add_entry(self)
  end
  
end

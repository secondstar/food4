class FoursquareReview < ActiveRecord::Base
  validates :name, :presence => true

  attr_accessor :foursquare_reaper, :notebook
  
  has_many :snapshots, as: :review
  
  def self.most_recent
    last(10)
  end
  
  def archive(clock=DateTime)
    return false unless valid?
    self.archived_at = clock.now
    notebook.add_entry(self)
  end
  
end

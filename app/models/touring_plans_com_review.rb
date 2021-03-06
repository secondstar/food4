require 'date'
require 'active_record'

class TouringPlansComReview < ActiveRecord::Base
  # has_many :eateries, through: :snapshots
  has_many :snapshots, as: :review
  belongs_to :district
  
  attr_accessor :notebook
  
  def self.most_recent
    all
  end
  
  def archive(clock=DateTime)
    return false unless valid?
    self.archived_at = clock.now
    notebook.add_entry(self)
  end

  
end

require 'date'
require 'active_record'

class Eatery < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :district
  attr_accessor :notebook
  
  def self.most_recent
    all
  end
  
  def publish(clock=DateTime)
    return false unless valid?
    self.published_at = clock.now
    notebook.add_entry(self)
  end


end
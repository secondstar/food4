require 'date'
require 'active_record'

class Addendum < ActiveRecord::Base
  belongs_to :portrayal, polymorphic: true
  
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

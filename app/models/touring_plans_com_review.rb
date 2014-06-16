require 'date'
require 'active_record'

class TouringPlansComReview < ActiveRecord::Base
  
  attr_accessor :notebook
  
  def archive(clock=DateTime)
    return false unless valid?
    self.archived_at = clock.now
    notebook.add_entry(self)
  end

  
end

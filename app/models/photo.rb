require 'active_record'

class Photo < ActiveRecord::Base

  attr_accessor :notebook
  
  def publish(clock=DateTime)
    return false unless valid?
    self.published_at = clock.now
    notebook.add_entry(self)
  end
  
end

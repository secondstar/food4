require 'active_record'

class Photo < ActiveRecord::Base

  attr_accessor :notebook
  
  def self.most_recent
    all
  end
  
  def publish(clock=DateTime)
    return false unless valid?
    self.published_at = clock.now
    notebook.add_entry(self)
  end

  belongs_to :photogenic, :polymorphic => true #photogenics include districts and eateries
  
end

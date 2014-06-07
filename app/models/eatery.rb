require 'date'
class Eatery
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  attr_accessor :notebook, :name, :permalink, :published_at
  
  def initialize(attrs={ })
    attrs.each do |k,v|
      send("#{k}=",v)
    end
  end
  
  def persisted?
    false
  end
  
  def publish(clock=DateTime)
    self.published_at = clock.now
    notebook.add_entry(self)
  end

end
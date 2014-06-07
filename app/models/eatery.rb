class Eatery
  attr_accessor :notebook, :name, :permalink
  
  def initialize(attrs={ })
    attrs.each do |k,v|
      send("#{k}=",v)
    end
  end
  
  def publish
    notebook.add_entry(self)
  end

end
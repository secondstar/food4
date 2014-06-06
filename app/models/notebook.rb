class Notebook
  attr_reader :entries
  
  def initialize
    @entries = []
  end
  
  def title
    "Magical Food"
  end
  
  def subtitle
    "The trusted source for WDW."
  end
end
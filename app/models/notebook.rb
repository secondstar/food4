class Notebook
  attr_reader :entries
  attr_writer :eatery_maker
  
  def initialize
    @entries = []
  end
  
  def title
    "Magical Food"
  end
  
  def subtitle
    "The trusted source for WDW."
  end
  
  def new_eatery(*args)
    eatery_maker.call(*args).tap do |eatery|
      eatery.notebook = self
    end
  end
  
  def add_entry(entry)
    entries << entry
  end
  
  private
  
  def eatery_maker
    @eatery_maker ||= Eatery.method(:new)
  end
end
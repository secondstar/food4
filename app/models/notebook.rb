class Notebook
  attr_reader :entries
  attr_writer :eatery_maker
  
  def initialize(entry_fetcher=Eatery.method(:all))
    @entry_fetcher = entry_fetcher
  end
  
  def title
    "Magical Food"
  end
  
  def subtitle
    "The trusted source for WDW."
  end
  
  def entries
    fetch_entries.sort_by{|e| e.name}
  end
  def new_eatery(*args)
    eatery_maker.call(*args).tap do |eatery|
      eatery.notebook = self
    end
  end
  
  def add_entry(entry)
    # entries << entry
    entry.save
  end
  
  private
  
  def fetch_entries
    @entry_fetcher.()
  end
  def eatery_maker
    @eatery_maker ||= Eatery.public_method(:new)
  end
end
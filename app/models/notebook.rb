class Notebook
  attr_reader :entries
  attr_writer :eatery_maker, :district_maker
  
  def initialize(entry_fetcher=Eatery.public_method(:most_recent))
    @entry_fetcher = entry_fetcher
  end
  
  def title
    "Magical Food"
  end
  
  def subtitle
    "The trusted source for WDW."
  end
  
  def entries
    fetch_entries
  end
  
  def new_eatery(*args)
    eatery_maker.call(*args).tap do |eatery|
      eatery.notebook = self
    end
  end

  def find_or_initialize_district(*args)
    district_maker.call(*args).tap do |d|
      d.notebook = self
    end
  end
  
  def add_entry(entry)
    entry.save
  end
  
  private
  
  def fetch_entries
    @entry_fetcher.()
  end
  
  def district_maker
    # @district_maker ||= District.find_or_initialize_by(district['permalink']) # test if resort district already exists
    @district_maker ||= District.public_method(:find_or_initialize_by) # test if resort district already exists
  end

  def eatery_maker
    @eatery_maker ||= Eatery.public_method(:new)
  end
end
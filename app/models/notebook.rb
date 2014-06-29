class Notebook
  attr_reader :entries
  attr_writer :eatery_maker, :district_maker, :tpcr_maker, :dfb_review_maker,  :snapshot_maker, :photo_maker
  
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

  def new_snapshot(*args)
    snapshot_maker.call(*args).tap do |snapshot|
      snapshot.notebook = self
    end
  end

  def new_tpcr(*args)
    tpcr_maker.call(*args).tap do |tpcr|
      tpcr.notebook = self
    end
  end
  
  def new_dfb_review(*args)
    dfb_review_maker.call(*args).tap do |dfb_review|
      dfb_review.notebook = self
    end
  end
  
  def new_eatery(*args)
    eatery_maker.call(*args).tap do |eatery|
      eatery.notebook = self
    end
  end

  def find_or_initialize_eatery(*args)
    eatery_maker.call(*args).tap do |eatery|
      eatery.notebook = self
    end
  end

  def new_photo(*args)
    photo_maker.call(*args).tap do |photo|
      photo.notebook = self
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
    @district_maker ||= District.public_method(:find_or_initialize_by) # test if resort district already exists
  end

  def eatery_maker
    @eatery_maker ||= Eatery.public_method(:find_or_initialize_by)
  end
  
  def photo_maker
    @photo_maker ||= Photo.public_method(:new)
  end

  def snapshot_maker
    @snapshot_maker ||= Snapshot.public_method(:new)
  end
  
  def tpcr_maker
    @tpcr_maker ||= TouringPlansComReview.public_method(:new)
  end

  def dfb_review_maker
    @dfb_review_maker ||= DisneyfoodblogComReview.public_method(:new)
  end
  
end
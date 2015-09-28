#like photographer.rb
require 'foursquare2'

require 'ostruct'

class FoursquareReaper
  attr_reader :entries
  attr_writer :fsq_review_source

  def initialize(entry_fetcher = FoursquareReview.public_method(:all))
    @entry_fetcher = entry_fetcher
    # @params = params
    # @entries  = @params[:entries]
  end
  
 
  def entries
    _fetch_entries.sort_by{|e| e.name}.reverse.take(10)
  end
  
  def fsq_review_source
    _fsq_review_maker
  end
  
  def new_fsq_review(*args)
    fsq_review_source.call(*args).tap do |review|
      review.foursquare_reaper = self
    end
  end
 
  def add_entry(entry)
    entry.save
  end
  
  private
  
  def _fetch_entries
    @entry_fetcher.()
  end

  def _fsq_review_maker
    @fsq_review_source ||= FoursquareReview.public_method(:new)
  end

end
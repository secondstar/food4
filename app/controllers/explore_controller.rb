class ExploreController < ApplicationController
  def index
    @eateries = Notebook.new.entries.first(10)
  end
  
  def show
    @eateries
    # @eatery     = @eateries.entries.find(id)
    @eatery       = Eatery.first
  end
end

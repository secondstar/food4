class ExploreController < ApplicationController
  def index
    @eateries = Notebook.new.entries.first(10)
    @reviews  = FoursquareReview.take(10)
    @geojson = Array.new

    @reviews.each do |eatery|
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [eatery.lng, eatery.lat]
        },
        properties: {
          name: eatery.name,
          # address: eatery.street,
          :'marker-color' => '#00607d',
          :'marker-symbol' => 'circle',
          :'marker-size' => 'medium'
        }
      }
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @geojson }
    end
    
  end
  
  def show
    @eateries
    # @eatery     = @eateries.entries.find(id)
    @eatery       = Eatery.first
  end
end

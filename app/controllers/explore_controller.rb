class ExploreController < ApplicationController
  def index
    @eateries = Notebook.new.entries.search_by_full_name(params[:query])
    @geojson = Array.new

    @eateries.each do |eatery|
      foursquare_review = eatery.snapshots.foursquare.first.review
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [foursquare_review.lng, foursquare_review.lat]
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

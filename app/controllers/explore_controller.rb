class ExploreController < ApplicationController
  def index
    @eateries = Notebook.new.entries.search_by_full_name(params[:query])
    @geojson = Array.new

    @eateries.each do |eatery|
      foursquare_review = eatery.snapshots.foursquare.first.review
      @eatery_photo = eatery.photos.select("id",
        "url", "farm", "server", "flickr_id", "secret").first
      @eatery_photo_url = "https://farm#{@eatery_photo.farm}.staticflickr.com/#{@eatery_photo.server}/#{@eatery_photo.flickr_id}_#{@eatery_photo.secret}_s.jpg"
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
    @eatery = Notebook.new.entries.find(params[:id])
    
    @photos     = @eatery.photos
    if @photos.length < 10
      @photos = @photos + @eatery.district.photos
      if @photos.length < 10
      	@e = @eatery.district.eateries
      	@e.each {|e| @photos << e.photos}
      	@photos = @photos.flatten.to_a.first(10)
      end      
    end
    @photos = @photos.to_a
    @head_photo = @photos.last
    @photos     = @photos.first(5)
    # # @video = Eatery.find_video("#{ename} disney", 3)
    # @tweet_search_term = Eatery.find_tweets(ename)
    # @eatery_dfb_links = @eatery.addendums.where('href IS NOT NULL')
    @dfb_snapshots = @eatery.snapshots.dfb
    if @dfb_snapshots.length > 0
      @eatery_dfb_tips = @dfb_snapshots.first.addendums.where(category: 'tips')
      @eatery_dfb_affinities = @dfb_snapshots.first.addendums.where(category: 'affinity')
      @eatery_dfb_bloggings = @dfb_snapshots.first.addendums.where(category: 'blogging')
      
    end
    
  end
end

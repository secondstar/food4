class DistrictsController < ApplicationController

  # GET /districts
  # GET /districts.json
  def index
    @districts = District.search_location(params[:search_location])
    
    @photos   = Photo.last(4)
    @photo    = @photos.first
    @photos   = @photos.last(3)
    # @tweet_search_term = 'wdw Food'
  end

  # GET /districts/1
  # GET /districts/1.json
  # def show
  #   @district = District.find_by_permalink(params[:id])
  # end
  def show
    @district = District.find_by_permalink(params[:id])
    @eateries = @district.eateries
    @photos    = @district.photos.all
    if @photos.length < 5
    	@photos =[]
    	@e = @district.eateries
    	@e.each{|e| @photos << e.photos}
    	@photos = @photos.flatten.to_a
    end
    
    @photo    = @photos.last
    @photos   = @photos.to_a.shuffle!.first(2)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @district }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_district
    #   @district = District.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def district_params
      params.require(:district).permit(:name)
    end
end

class DistrictsController < ApplicationController

  # GET /districts
  # GET /districts.json
  def index
    @districts = District.all
    @eateries =  Eatery.location_search(params[:search_location])
    # @photos   = Photo.all.shuffle!.first(3)
    # @photo    = @photos.first
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

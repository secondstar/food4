class EateriesController < ApplicationController
  def new
    @eatery = @notebook.new_eatery
  end

  def create
    @eatery = @notebook.new_eatery(eatery_params)
    if @eatery.publish
      redirect_to root_path, notice: "Eatery added!"
    else
      render "new"
    end
  end
  
  def show
    @eatery = Eatery.find_by_permalink(params[:id])
    
    # ename = @eatery.name
    # ## FIX: For when photos are not present for an eatery, a default array of photos need to be created to avoid this: undefined method `photos' for nil:NilClass
    # # @default_photo = {:farm => 3, :server  => '2551',:flickr_id => '3692961395',:secret => '43719b8b50',:owner => 'lyght55'}
    # @photos     = @eatery.photos
    # @photos     = @photos.shuffle!.first(3)
    # @head_photo = @photos.first     
    # # @video = Eatery.find_video("#{ename} disney", 3)
    # @tweet_search_term = Eatery.find_tweets(ename)
    # @eatery_dfb_links = @eatery.addendums.where('href IS NOT NULL')
    # @eatery_dfb_tips = @eatery.addendums.where('href IS NULL')    
  end
  
  private
  
  def eatery_params
    params.require(:eatery).permit(:name, :permalink)
  end
  
end

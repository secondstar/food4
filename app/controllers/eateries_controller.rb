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
    @photos     = @eatery.photos
    if @photos.length < 10
      @photos = @photos + @eatery.district.photos
      if @photos.length < 10
      	@e = @eatery.district.eateries
      	@e.each {|e| @photos << e.photos}
      	@photos = @photos.flatten.to_a.shuffle!.first(10)
      end      
    end
    @photos = @photos.to_a.shuffle!
    @head_photo = @photos.last
    @photos     = @photos.first(3)
    # # @video = Eatery.find_video("#{ename} disney", 3)
    # @tweet_search_term = Eatery.find_tweets(ename)
    # @eatery_dfb_links = @eatery.addendums.where('href IS NOT NULL')
    @eatery_dfb_tips = @eatery.snapshots.last.addendums.where(category: 'tips')
    @eatery_dfb_affinities = @eatery.snapshots.last.addendums.where(category: 'affinity')
    @eatery_dfb_bloggings = @eatery.snapshots.last.addendums.where(category: 'blogging')
  end
  
  private
  
  def eatery_params
    params.require(:eatery).permit(:name, :permalink)
  end
  
end

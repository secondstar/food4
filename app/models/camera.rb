################
require 'httparty'
require 'logger'
require 'ostruct'

class Camera
  attr_accessor :notebook
  
  include HTTParty
  format :json
  
  def initialize(photo_target)
    @photo_target = photo_target
  end
  # keep this a basic point and shoot camera
  # aim the camera at a location, and get as many relevant shots as you can.
  # The question of what to shoot and how many stays with the Photographer.
  
  def shoot_collection
    # q = flickr_query
    # q = CameraAngles.new(@photo_target).basic
    @basic_photos = []
    @tagged_photos = []
    q = CameraAngle.new(@photo_target).choose_angle
    # puts "************** q = #{q}"
    @basic_results = Camera.get("https://query.yahooapis.com/v1/public/yql", :query =>  {:q => q, :format =>  'json'})
    # puts "************** @basic_results = #{@basic_results}"
    
    basic_results_count = @basic_results['query']['count']
    unless basic_results_count == 0
    # basic_results_count = 0
      @basic_photos = @basic_results['query']['results']['photo']
      @basic_photos = [] << @basic_photos if basic_results_count < 2 # HTTParty's yql does not put results < 2 into an array
    end
    if basic_results_count < @photo_target.quantity.to_i
      @photo_target.angle = 'tags_only'
      q = CameraAngle.new(@photo_target).choose_angle
      @tagged_results = Camera.get("https://query.yahooapis.com/v1/public/yql", :query =>  {:q => q, :format =>  'json'})
      # puts "*************** @tagged_photos *****************"
      # puts @tagged_results
      # puts "*************************************************"
      tagged_results_count = @tagged_results['query']['count']
      unless tagged_results_count == 0
        @tagged_photos = @tagged_results['query']['results']['photo']
        @tagged_photos = [] << @tagged_photos if tagged_results_count < 2 # HTTParty's yql does not put results < 2 into an array
      end
    end

    @photos = @basic_photos + @tagged_photos
    
  end
  
end
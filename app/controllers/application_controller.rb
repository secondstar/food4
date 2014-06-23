class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :find_resort_and_downtown_dining
  
  before_action :init_notebook
  
  private
  
  def init_notebook
    @notebook =  THE_NOTEBOOK
    @world_harvester = THE_WORLD_HARVESTER
  end
  
  def find_resort_and_downtown_dining
    @parks = District.where(:is_park => true)
    @lodgings = District.where(:is_park => false)
    
  end
  
  # def cache_pages_for_12_hours
  #   response.headers['Cache-Control'] = 'public, max-age=43200'
  # end
  
end

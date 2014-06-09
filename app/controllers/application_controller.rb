class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :init_notebook
  
  private
  
  def init_notebook
    @notebook =  THE_NOTEBOOK
    @world_harvester = THE_WORLD_HARVESTER
  end
  
  
end

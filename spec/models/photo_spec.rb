require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/photo'

describe Photo do
  include SpecHelpers
  before do
    @it = Photo.new(:url => "NAME")
    @ar = @it
    @ar_class = Photo
  end
  

end
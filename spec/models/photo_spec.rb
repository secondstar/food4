require 'minitest/autorun'
require_relative '../../app/models/photo'

describe Photo do
  include SpecHelpers
  before do
    @it = Photo.new(:url => "NAME")
    @ar = @it
    @ar_class = Photo
  end
  

end
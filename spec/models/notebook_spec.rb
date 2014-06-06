require 'minitest/autorun'
require_relative '../../app/models/notebook'

describe Notebook do
  before do
    @it = Notebook.new
  end
  
  it "has no entries" do
    @it.entries.must_be _empty
  end
end
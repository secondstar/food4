# require 'minitest/autorun'
require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_reaper'
require "ostruct"

describe DfbNewReviewArchiver do
  let(:permalink) {"cheshire-cafe"}
  let(:eatery_name) {"Cheshire Cafe"}
  subject { DfbNewReviewArchiver.new(eatery_name, permalink)}
  
  describe 'store' do
    it 'works' do
      # subject.store.must_equal "something"
      # This uses a chain of other methods and saves to DisneyfoodblogComReview, thus no test for values at this time
    end
  end
end
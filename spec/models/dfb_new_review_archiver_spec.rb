# require 'minitest/autorun'
require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_new_review_archiver'
require "ostruct"

describe DfbNewReviewArchiver do
  let(:permalink) {"cheshire-cafe"}
  let(:eatery_name) {"Cheshire Cafe"}
  subject { DfbNewReviewArchiver.new(eatery_name, permalink)}
  
  
  describe 'store' do
    # it 'works' do
    #   subject.store.must_equal "something"
    #   # This uses a chain of other methods and saves to DisneyfoodblogComReview, thus no test for values at this time
    # end
  end
  
  describe '#_merge_model_params_with__scanned_in_review' do
    it 'works' do
      
      subject._merge_model_params_with__scanned_in_review.must_equal "something"
    end
    
    it 'is a Array' do
      subject.must_be_kind_of Array
    end

    it "returns 45 items" do
      subject.length.must_equal 45
    end
    
  end
end
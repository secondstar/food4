require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_review_details'
require "ostruct"

describe DfbReviewDetails do
  describe 'scan' do
    params = {path: "whispering-canyon-cafe", yql_css_parse: '#primary .entry-content p' }
    let(:target) { OpenStruct.new(params) }
    subject { DfbReviewDetails.new(target: target).scan }
    
    # it 'works' do
    #   subject.must_equal "someting"
    # end
    
    it 'is a hash' do
      subject.must_be_kind_of Hash
    end
    
    it 'constains a hash with 10 elements' do
      subject.size.must_equal 10
    end
  end
end
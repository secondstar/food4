# require 'minitest/autorun'
require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_new_review_archiver'
require "ostruct"

describe DfbNewReviewArchiver do
  before do
    @dnra = DfbNewReviewArchiver.new(eatery_name, permalink)
  end
  
  
  describe '#_scanned_in_review golden path' do
    let(:permalink) {"cheshire-cafe"}
    let(:eatery_name) {"Cheshire Cafe"}
    subject { @dnra._scanned_in_review }
    
    # it 'works' do
    #   subject.must_equal "something"
    # end
    
    it 'must be a Hash' do
      subject.must_be_kind_of Hash
    end
    
    it 'must have a length of 12' do
      subject.length.must_equal 12
    end
    
  end
  describe '#_scanned_in_review whispering canyon cafe' do
    let(:permalink) {"whispering-canyon-cafe"}
    let(:eatery_name) {"Whispering Canyon Cafe"}
    subject { @dnra._scanned_in_review }
  
    # it 'works' do
    #   subject.must_equal "something"
    # end
  
    it 'must be a Hash' do
      subject.must_be_kind_of Hash
    end
  
    it 'must have a length of 10' do
      subject.length.must_equal 10
    end
    
  end
  describe '#_scanned_in_review Scat Cats Club' do
    let(:permalink) {"scat-cats"}
    let(:eatery_name) {"Scat Cats Club"}
    subject { @dnra._scanned_in_review }
  
    # it 'works' do
    #   subject.must_equal "something"
    # end
  
    it 'must be a Hash' do
      subject.must_be_kind_of Hash
    end
  
    it 'must have a length of 11' do
      subject.length.must_equal 11
    end
    
  end

  describe '#store golden path' do
    let(:permalink) {"cheshire-cafe"}
    let(:eatery_name) {"Cheshire Cafe"}
    subject { @dnra.store }
    
    it 'returns an Array' do
      subject.must_be_kind_of Array
    end

    it 'has one element only' do
      subject.length.must_equal 1
    end
    
    it 'has a Hash for the first element' do
      subject.first.must_be_kind_of Hash
    end
  end
end
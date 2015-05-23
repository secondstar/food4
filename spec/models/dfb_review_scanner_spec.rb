require 'nokogiri'
require 'open-uri'
require "ostruct"

require_relative '../spec_helper_lite'

require_relative '../../app/models/dfb_harvester'
require_relative '../../app/models/dfb_yql_collector'
require_relative '../../app/models/dfb_review_scanner'

describe DfbReviewScanner do
  
  before do
    params = { path: "cheshire-cafe", yql_css_parse: '.entry-content'}
    @target = OpenStruct.new(params)
    # add nokogiri scrape of review to @target
    dh = DfbHarvester.new(@target)
    scraped_review_listing_page = dh.scrape_review_listing_page
  end

  describe 'find_tips' do
    subject { DfbReviewScanner.new(@target).find_tips }
    
    # it 'works' do
    #   subject.must_equal "someting"
    # end
    
    it 'is an Array' do
      subject.must_be_kind_of Array
    end
    
    it 'has a Hash as the first element of that Array' do
      subject.first.must_be_kind_of Hash
    end
    
    it 'has 4 elements in the first Hash' do
      subject.first.length.must_equal 4
    end
  end
  describe '#find_affinities with golden path' do

    subject { DfbReviewScanner.new(@target).find_affinities }
    
    # test @target because the method leans on other code that generates the @target
    it 'has a @target that contains "You Might also Like:"' do
      @target.doc.css("strong").last.text.must_equal "You Might also Like:"
    end

    it 'has a @target that contains a path' do
      @target.path.must_equal "cheshire-cafe"
    end
    
    # test the method's code


    # it 'works' do
    #   # show the currently resulting code in the error since this method is not currently fully tested
    #   subject.must_equal "something"
    # end

    it 'is an Array' do
        subject.must_be_kind_of Array
    end
    
    it 'is an Array with a length of 3' do
      subject.length.must_equal 3
    end
    
    it 'has a Hash as the first element of the Array' do
      subject.first.must_be_kind_of Hash
    end
    
    it 'has the first element of the Array is a Hash with a length of 4' do
      subject.first.length.must_equal 4
    end
  end

  describe '#find_affinities edge case 01' do
    # "You Might also Like:" is not nested in a <p />
    before do
      params = { path: "whispering-canyon-cafe", yql_css_parse: '.entry-content'}
      @target = OpenStruct.new(params)
      # add nokogiri scrape of review to @target
      dh = DfbHarvester.new(@target)
      scraped_review_listing_page = dh.scrape_review_listing_page
    end

    subject { DfbReviewScanner.new(@target).find_affinities }
    
    # test @target because the method leans on other code that generates the @target
    it 'has a @target that contains "You Might also Like:"' do
      @target.doc.css("strong").last.text.must_equal "You Might also Like:"
    end

    it 'has a @target that contains a path' do
      @target.path.must_equal "whispering-canyon-cafe"
    end
    
    # test the method's code

    # it 'works' do
    #   # show the currently resulting code in the error since this method is not currently fully tested
    #   subject.must_equal "someting"
    # end

    it 'is an Array' do
        subject.must_be_kind_of Array
    end
    
    it 'is an Array with a length of 2' do
      subject.length.must_equal 2
    end
    
    it 'has a Hash as the first element of the Array' do
      subject.first.must_be_kind_of Hash
    end
    
    it 'has the first element of the Array is a Hash with a length of 4' do
      subject.first.length.must_equal 4
    end
  end
  
end
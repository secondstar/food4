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
    @drs = DfbReviewScanner.new(@target)
  end

  describe '#find_bloggings golden path' do
    subject { @drs.find_bloggings }
  
    # it 'works' do
    #   subject.must_equal "someting"
    # end
  
    it 'is an Array' do
      subject.must_be_kind_of Array
    end
    #
    it 'has 10 elements in the array' do
      subject.length.must_equal 10
    end
    it 'has a Hash as the first element of that Array' do
      subject.first.must_be_kind_of Hash
    end

    it 'has 4 elements in the first Hash' do
      subject.first.length.must_equal 4
    end

    it 'has a hash with a tip for Snacking Budget' do
      subject.first['description'].must_equal "Tip from the DFB Guide: Budgeting For Disney Snacks!"
    end
  end
  
  describe '#find_tips golden path' do
    
    subject { @drs.find_tips }
    
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
  describe '#find_tips edge case liberty-inn' do
    # "liberty-inn"
    # "You Might also Like:" is  not nested in a <p />
    before do
      params = { path: "liberty-inn", yql_css_parse: '.entry-content'}
      @target = OpenStruct.new(params)
      # add nokogiri scrape of review to @target
      dh = DfbHarvester.new(@target)
      scraped_review_listing_page = dh.scrape_review_listing_page
      @drs =  DfbReviewScanner.new(@target)
    end
    
    subject { @drs.find_tips }
    
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
    
    it 'has a category of tips for the first element' do
      subject.first['category'].must_equal "tips"
    end

    it 'has an accurate description for the first element' do
      subject.first['description'].must_equal "<li>Don’t forget to stop into the American Adventure rotunda to hear the goose-bump inspiring Voices of Liberty <em>a capella</em> vocal group. They perform several scheduled sets per day of folk, patriotic, and classic American songs. Check the Times Guide when you enter the park for showtimes.</li>"
    end
  end

  describe '#find_affinities with golden path' do

    subject { @drs.find_affinities }
    
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
    #   subject.must_equal "someting"
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

  describe 'edge case whispering-canyon-cafe' do
    # "You Might also Like:" is not nested in a <p />
    before do
      params = { path: "whispering-canyon-cafe", yql_css_parse: '.entry-content'}
      @target = OpenStruct.new(params)
      # add nokogiri scrape of review to @target
      dh = DfbHarvester.new(@target)
      scraped_review_listing_page = dh.scrape_review_listing_page
      @drs = DfbReviewScanner.new(@target)
    end

    describe '#find_tips' do
      subject { @drs.find_tips }
    
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
      
      it 'has the first element of the Array is a Hash with a length of 4' do
        subject.first.length.must_equal 4
      end
      
      it 'has a hash with a tip for a quick lunch while waiting for Test Track' do
        subject.first['description'].must_equal "<li>You never know what’s going to happen at WCC — servers are on the lookout for ways to have fun with guests.</li>"
      end
      
    end

    describe '#find_affinities' do
      subject { @drs.find_affinities }
    
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
      # +[{"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/hoop-dee-doo-revue/", "description"=>"Hoop Dee Doo Revue", "category"=>"affinity"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/trails-end-restaurant/", "description"=>"Trail’s End Restaurant", "category"=>"affinity"}]
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
    
      it 'has a hash with the affinity for Hoop Dee Doo Revue' do
        subject.first['description'].must_equal "Hoop Dee Doo Revue"
      end
      it 'has the first element of the Array is a Hash with a length of 4' do
        subject.first.length.must_equal 4
      end
      
    end
    
    describe '#find_bloggings' do
      subject { @drs.find_bloggings }
    
      # it 'works' do
      #   subject.must_equal "someting"
      # end
    
      it 'is an Array' do
        subject.must_be_kind_of Array
      end
      #
      it 'has 10 elements in the array' do
        subject.length.must_equal 10
      end
      it 'has a Hash as the first element of that Array' do
        subject.first.must_be_kind_of Hash
      end

      it 'has 4 elements in the first Hash' do
        subject.first.length.must_equal 4
      end

      it 'has a hash with an article for Food Round-Up' do
        subject.first['description'].must_equal "Disney Food Post Round-Up: March 1, 2015"
      end
    end
    
    
  end
  
  describe 'edge case cool-wash-pizza' do
    before do
      params = { path: "cool-wash-pizza", yql_css_parse: '.entry-content'}
      @target = OpenStruct.new(params)
      # add nokogiri scrape of review to @target
      dh = DfbHarvester.new(@target)
      scraped_review_listing_page = dh.scrape_review_listing_page
      @drs = DfbReviewScanner.new(@target)
    end
    
    describe '#find_tips' do
      subject { @drs.find_tips }
    
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
      
      it 'has the first element of the Array is a Hash with a length of 4' do
        subject.first.length.must_equal 4
      end
      
      it 'has a hash with a tip for a quick lunch while waiting for Test Track' do
        subject.first['description'].must_equal "<li>Long wait for Test Track? Grab a quick lunch from Cool Wash Pizza to help pass the time.</li>"
      end
      
    end
    describe '#find_affinities' do
      subject { @drs.find_affinities }
    
      # test @target because the method leans on other code that generates the @target
      it 'has a @target that contains "You Might also Like:"' do
        @target.doc.css("strong").last.text.must_equal "You Might also Like:"
      end

      it 'has a @target that contains a path' do
        @target.path.must_equal "cool-wash-pizza"
      end
    
      # test the method's code


      # it 'works' do
      #   # show the currently resulting code in the error since this method is not currently fully tested
      #   subject.must_equal "someting"
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
      
      it 'has a hash with the affinity for Hoop Dee Doo Revue' do
        subject.first['description'].must_equal "Boardwalk Pizza Window"
      end
      
      
    end
    
    describe '#find_bloggings' do
      subject { @drs.find_bloggings }
    
      # it 'works' do
      #   subject.must_equal "someting"
      # end
    
      it 'is an Array' do
        subject.must_be_kind_of Array
      end
      #
      it 'has 2 elements in the array' do
        subject.length.must_equal 2
      end
      it 'has a Hash as the first element of that Array' do
        subject.first.must_be_kind_of Hash
      end

      it 'has 4 elements in the first Hash' do
        subject.first.length.must_equal 4
      end

      it 'has a hash with a tip for Hoop Dee Doo Revue' do
        subject.first['description'].must_equal "Disney Food Post Round-Up: April 22, 2012"
      end
    end
    
  end
  describe 'edge case splash-terrace' do
    before do
      params = { path: "splash-terrace", yql_css_parse: '.entry-content'}
      @target = OpenStruct.new(params)
      # add nokogiri scrape of review to @target
      dh = DfbHarvester.new(@target)
      scraped_review_listing_page = dh.scrape_review_listing_page
      @drs = DfbReviewScanner.new(@target)
    end
    
    describe '#find_tips' do
      subject { @drs.find_tips }
    
      # it 'works' do
      #   subject.must_equal "something"
      # end
    
      it 'is an Array' do
        subject.must_be_kind_of Array
      end
      
      it 'has 1 tip' do
        subject.length.must_equal 1
      end
    
      it 'has an accurate description for the first element' do
        subject.first["description"].must_equal "<li>Splash Terrace is open seasonally</li>"
      end
    end
    describe '#find_affinities' do
      subject { @drs.find_affinities }
    
      # test @target because the method leans on other code that generates the @target
      it 'has a @target that contains "You Might also Like:"' do
        @target.doc.css("strong").last.text.must_equal "You Might also Like:"
      end

      it 'has a @target that contains a path' do
        @target.path.must_equal "splash-terrace"
      end
    
      # test the method's code


      # it 'works' do
      #   # show the currently resulting code in the error since this method is not currently fully tested
      #   subject.must_equal "someting"
      # end

      it 'is an Array' do
          subject.must_be_kind_of Array
      end
    
      it 'is an Array with a length of 4' do
        subject.length.must_equal 4
      end
    
      it 'has a Hash as the first element of the Array' do
        subject.first.must_be_kind_of Hash
      end
    
      it 'has the first element of the Array is a Hash with a length of 4' do
        subject.first.length.must_equal 4
      end
      
      it 'has a hash with the affinity for St. John’s Pool Bar' do
        subject.first['description'].must_equal "St. John’s Pool Bar"
      end
      
      
    end
    
    describe '#find_bloggings' do
      subject { @drs.find_bloggings }
    
      # it 'works' do
      #   subject.must_equal "someting"
      # end
    
      it 'is an Array' do
        subject.must_be_kind_of Array
      end
      #
      it 'has zero elements in the array' do
        subject.length.must_equal 0
      end
    end
    
  end
  
  describe 'edge case fountain-view' do
    before do
      params = { path: "fountain-view", yql_css_parse: '.entry-content'}
      @target = OpenStruct.new(params)
      # add nokogiri scrape of review to @target
      dh = DfbHarvester.new(@target)
      scraped_review_listing_page = dh.scrape_review_listing_page
      @drs = DfbReviewScanner.new(@target)
    end
    
    describe '#find_tips' do
      subject { @drs.find_tips }
    
      # it 'works' do
      #   subject.must_equal "something"
      # end

      it 'is an Array' do
        subject.must_be_kind_of Array
      end

      it 'has 2 tips' do
        subject.length.must_equal 2
      end

      it 'has an accurate description for the first element' do
        subject.first["description"].must_equal "<li>If you’re craving you’re favorite Starbucks beverage the way you enjoy it at home, Fountain View is the place to find it in Epcot.</li>"
      end
    end
    describe '#find_affinities' do
      subject { @drs.find_affinities }
    
      # test @target because the method leans on other code that generates the @target
      # it 'has a @target that contains "You Might also Like:"' do
      #   @target.doc.css("strong").last.text.must_equal "You Might also Like:"
      # end

      # it 'has a @target that contains a path' do
      #   @target.path.must_equal "fountain-view"
      # end
    
      # test the method's code


      # it 'works' do
      #   # show the currently resulting code in the error since this method is not currently fully tested
      #   subject.must_equal "someting"
      # end
      #
      it 'is an Array' do
          subject.must_be_kind_of Array
      end

      it 'is an Array with a length of 4' do
        subject.length.must_equal 1
      end

      it 'has a Hash as the first element of the Array' do
        subject.first.must_be_kind_of Hash
      end

      it 'has the first element of the Array is a Hash with a length of 4' do
        subject.first.length.must_equal 4
      end

      it 'has a hash with the affinity for Main Street Bakery' do
        subject.first['description'].must_equal "Main Street Bakery"
      end
      
      
    end
    
    describe '#find_bloggings' do
      subject { @drs.find_bloggings }
    
      # it 'works' do
      #   subject.must_equal "someting"
      # end
    
      it 'is an Array' do
        subject.must_be_kind_of Array
      end

      it 'has 7 elements in the array' do
        subject.length.must_equal 7
      end
      
      it 'has an Hash as the first element in the Array' do
        subject.first.must_be_kind_of Hash
      end
      
      it 'has a description in the first element in the Array' do
        subject.first["description"].must_equal "News! Starbucks “You Are Here” Mugs For Sale Again in Epcot"
      end
    end
    
  end
  
  describe 'edge case lartisan-des-glaces' do
    before do
      params = { path: "lartisan-des-glaces", yql_css_parse: '.entry-content'}
      @target = OpenStruct.new(params)
      # add nokogiri scrape of review to @target
      dh = DfbHarvester.new(@target)
      scraped_review_listing_page = dh.scrape_review_listing_page
      @drs = DfbReviewScanner.new(@target)
    end
    
    describe '#find_tips' do
      subject { @drs.find_tips }

      # it 'works' do
      #   subject.must_equal "something"
      # end

      it 'is an Array' do
        subject.must_be_kind_of Array
      end

      it 'has zero tips' do
        subject.length.must_equal 0
      end

    end
    describe '#find_affinities' do
      subject { @drs.find_affinities }
      #
      # test @target because the method leans on other code that generates the @target
      it 'has a @target that contains "You Might also Like:"' do
        @target.doc.css("strong").last.text.downcase.gsub(/[^a-z0-9\s]/i, '') == "you might also like"
      end

      it 'has a @target that contains a path' do
        @target.path.must_equal "lartisan-des-glaces"
      end

      # test the method's code


      # it 'works' do
      #   # show the currently resulting code in the error since this method is not currently fully tested
      #   subject.must_equal "someting"
      # end

      it 'is an Array' do
          subject.must_be_kind_of Array
      end

      it 'is an Array with a length of 1' do
        subject.length.must_equal 1
      end

      it 'has a Hash as the first element of the Array' do
        subject.first.must_be_kind_of Hash
      end

      it 'has the first element of the Array is a Hash with a length of 4' do
        subject.first.length.must_equal 4
      end

      it 'has a hash with the affinity for Main Street Ice Cream Parlor' do
        subject.first['description'].must_equal "Main Street Ice Cream Parlor"
      end


    end
    
    describe '#find_bloggings' do
      subject { @drs.find_bloggings }
    
      # it 'works' do
      #   subject.must_equal "something"
      # end
    
      it 'is an Array' do
        subject.must_be_kind_of Array
      end

      it 'has zero elements in the array' do
        subject.length.must_equal 0
      end
      
    end
    
  end
  
end
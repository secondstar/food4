require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/foursquare'
require "ostruct"

describe Foursquare do
  subject { Foursquare.new }

  describe "#title" do
    # params = {path: "whispering-canyon-cafe", yql_css_parse: 'article .entry-content p' }
    # let(:target) { OpenStruct.new(params) }
    it "works" do
      
      subject.title.must_equal "i am foursquare"
    end
  end
  
  describe '#search_reviews' do
    # it 'works' do
    #   subject.search_venues.must_equal "something"
    # end

    # https://github.com/intridea/hashie
    it 'is a Hashie::Mash' do
      subject.search_reviews.must_be_kind_of Hashie::Mash
    end
    
    # Casey's Corner example
    it 'has "venues" as the first element' do
      subject.search_reviews( "Casey's Corner").first[0].must_equal "venues"
    end
    
    it 'has \'Casey\'s Corner\' as the name for its first venue' do
      subject.search_reviews( "Casey's Corner").first[1][0][:name].must_equal 'Casey\'s Corner'
    end


    it 'has \'Walt Disney World\' as part of the CrossStreet for its first venue' do
      subject.search_reviews( "Casey's Corner").first[1][0][:location][:crossStreet].must_include 'Walt Disney World'
    end
    
    it 'has \'Casey\'s Corner\' as the name for its first venue' do
      subject.search_reviews( "Casey's Corner").first[1].first[:name].must_equal "Casey's Corner"
    end
    
    # Cheshire Cafe is the name in touringplans.com, but not foursquare.com & needs conversion
    it 'has \'Cheshire Cafe\' as the name of its first venue' do
      subject.search_reviews("Cheshire Cafe").first[1].first[:name].must_equal "Cheshire Café"
    end
  end

  describe '#find_review using a name foursquare.com knows' do
    let(:found_review) { subject.find_review( "Casey's Corner") }
    
    # it 'works' do
    #   subject.find_venue( "Casey's Corner").must_equal "someting"
    #   # subject.search_venues( "Casey's Corner").first[1].detect {|v| v[:name] == "Casey's Corner"}
    #
    # end

    it 'is a kind of Hashie::Mash' do
      found_review.first.must_be_kind_of Hashie::Mash
    end
    
    it 'has the name \'Casey\'s Corner\'' do
      found_review.first.name.must_equal "Casey's Corner"
    end
    
    it 'has a cross street that contains "Walt Disney World"' do
      found_review.first.location[:crossStreet].must_include "Walt Disney World"
    end
    
    it 'has a latitude' do
      found_review.first.location["lat"].must_equal 28.417839714711597
    end

    it 'has a longitude' do
      found_review.first.location["lng"].must_equal -81.58150327616565
    end
    
    ### altnerate names in the search
    it 'has an array as the second element' do
      found_review[1].must_be_kind_of Array
    end
    
    it 'has a string for the first element of the array of alternate names' do
      found_review[1].first.must_be_kind_of String
    end
    
    it 'has an alternative name' do
      found_review[1].first.length.must_be  :>, 1
    end
  end  

  describe '#find_review using a name foursquare.com does _not_ know but FoursquareBridge does' do
    # Cheshire Cafe is the name in touringplans.com, but not foursquare.com & needs conversion
    let(:query) { "Cheshire Cafe" }
    let(:found_review) { subject.find_review(query) }
    
    it 'has the name \'Cheshire Café\'' do
      found_review.first.name.must_equal "Cheshire Café"
    end
    
    it 'has a cross street that contains "Walt Disney World"' do
      found_review.first.location[:crossStreet].must_include "Walt Disney World"
    end
    
    it 'has a latitude' do
      found_review.first.location["lat"].must_be :>, 28.3
    end
    #
    it 'has a longitude' do
      found_review.first.location["lng"].must_be :<, -81.5
    end
  end

  describe '#find_review using a name foursquare.com does _not_ know and FoursquareBridge does _not_ ' do
    # Famous Dave is not a name in WDW.
    let(:query) { "Famous Dave" }
    let(:found_review) { subject.find_review(query) }
    
    # it 'does something' do
    #   found_review.must_equal "something"
    # end

    it 'returns nil value' do
      found_review.first.must_equal nil
    end
  end
  
  describe '#yield_default_venue' do
    let(:default_venue) { subject.yield_default_venue }
    
    it 'is a kind of Hashie::Mash' do
      default_venue.must_be_kind_of Hashie::Mash
    end
    
    it 'has a cross street that contains "Walt Disney World"' do
      default_venue.location[:crossStreet].must_include "Walt Disney World"
    end

    it 'has a latitude' do
      default_venue.location["lat"].must_be :>, 28.3
    end
    #
    it 'has a longitude' do
      default_venue.location["lng"].must_be :<, -81.5
    end
    
    it 'has "default venue" as its name' do
      default_venue.name.must_equal "default venue"
    end
    
  end
  
  describe '#_detect_desired_review with good query' do
    let(:query) { "Aloha Isle" }
    let(:review_search_results) { subject.search_reviews(query).first[1] }
    let(:detected_review) { subject._detect_desired_review(review_search_results, query) }
    
    it 'has the name "Aloha Isle"' do
      detected_review.name.must_equal "Aloha Isle"
    end
    
    it 'is a kind of Hashie::Mash' do
      detected_review.must_be_kind_of Hashie::Mash
    end
    
    it 'has a cross street that contains "Walt Disney World"' do
      detected_review.location[:crossStreet].must_include "Walt Disney World"
    end

    it 'has a latitude' do
      detected_review.location["lat"].must_be :>, 28.3
    end
    #
    it 'has a longitude' do
      detected_review.location["lng"].must_be :<, -81.5
    end
  end

  describe '#_create_default_review' do
    let(:query) { "Cheshire Cafe" }
    let(:review_search_results) { subject.search_reviews(query).first[1] }
    let(:created_default_review) { subject._create_default_review(review_search_results) }
    
    it 'has the name "Aloha Isle"' do
      created_default_review.name.must_equal "default venue"
    end
    
    it 'is a kind of Hashie::Mash' do
      created_default_review.must_be_kind_of Hashie::Mash
    end
    
    it 'has a cross street that contains "Walt Disney World"' do
      created_default_review.location[:crossStreet].must_include "Walt Disney World"
    end

    it 'has a latitude' do
      created_default_review.location["lat"].must_be :>, 28.3
    end

    it 'has a longitude' do
      created_default_review.location["lng"].must_be :<, -81.5
    end
  end

end
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
  
  describe '#search_venues' do
    # it 'works' do
    #   subject.search_venues.must_equal "something"
    # end

    # https://github.com/intridea/hashie
    it 'is a Hashie::Mash' do
      subject.search_venues.must_be_kind_of Hashie::Mash
    end
    
    # Casey's Corner example
    it 'has "venues" as the first element' do
      subject.search_venues( "Casey's Corner").first[0].must_equal "venues"
    end
    
    it 'has \'Casey\'s Corner\' as the name for its first venue' do
      subject.search_venues( "Casey's Corner").first[1][0][:name].must_equal 'Casey\'s Corner'
    end


    it 'has \'Walt Disney World\' as part of the CrossStreet for its first venue' do
      subject.search_venues( "Casey's Corner").first[1][0][:location][:crossStreet].must_include 'Walt Disney World'
    end
    
    it 'has \'Casey\'s Corner\' as the name for its first venue' do
      subject.search_venues( "Casey's Corner").first[1].first[:name].must_equal "Casey's Corner"
    end
    
    # Cheshire Cafe is the name in touringplans.com, but not foursquare.com & needs conversion
    it 'has \'Cheshire Cafe\' as the name of its first venue' do
      subject.search_venues("Cheshire Cafe").first[1].first[:name].must_equal "Cheshire Café"
    end
  end

  describe '#find_venue' do
    # it 'works' do
    #   subject.find_venue( "Casey's Corner").must_equal "someting"
    #   # subject.search_venues( "Casey's Corner").first[1].detect {|v| v[:name] == "Casey's Corner"}
    #
    # end
    it 'is a kind of Hashie::Mash' do
      subject.find_venue( "Casey's Corner").must_be_kind_of Hashie::Mash
    end
    
    it 'has the name \'Casey\'s Corner\'' do
      subject.find_venue("Casey's Corner").name.must_equal "Casey's Corner"
    end
    
    it 'has a cross street that contains "Walt Disney World"' do
      subject.find_venue("Casey's Corner").location[:crossStreet].must_include "Walt Disney World"
    end
    
    it 'has a latitude' do
      subject.find_venue("Casey's Corner").location["lat"].must_equal 28.417839714711597
    end

    it 'has a longitude' do
      subject.find_venue("Casey's Corner").location["lng"].must_equal -81.58150327616565
    end
    
    # Cheshire Cafe is the name in touringplans.com, but not foursquare.com & needs conversion
    it 'has the name \'Cheshire Café\'' do
      subject.find_venue("Cheshire Cafe").name.must_equal "Cheshire Café"
    end


  end  
end
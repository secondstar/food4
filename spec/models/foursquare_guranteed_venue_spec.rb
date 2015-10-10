require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/foursquare_guaranteed_venue.rb'


describe FoursquareGuaranteedVenue do
  subject { FoursquareGuaranteedVenue.find("unknown venue") }

  describe '#find("unknown venue")' do
    venue_name = "unknown venue"
    subject { FoursquareGuaranteedVenue.find("unknown venue") }
    let(:venue_search) { subject.first }
    
    # it 'does something' do
    #   subject.must_equal "something"
    # end
    
    it 'has a name equal to "default venue"' do
      venue_search.name.must_equal "default venue"
    end

    it 'has a string as an ID' do
      venue_search.id.must_be_kind_of String
    end

    it 'has a string as an address' do
      venue_search.location.formattedAddress.must_be_kind_of Array
    end

    it 'has a string as a crossStreet' do
      venue_search.location.crossStreet.must_be_kind_of String
    end

    it 'has a Float as a lat' do
      venue_search.location.lat.must_be_kind_of Float
    end

    it 'has a Float as a lng' do
      venue_search.location.lat.must_be_kind_of Float
    end

  end

  describe '#find eatery that foursquare.com knows of in WDW' do
    venue_name = "Aloha Isle"
    subject { FoursquareGuaranteedVenue.find(venue_name) }
    let(:venue_search) { subject.first }
    
    # it 'does something' do
    #   subject.first.must_equal "something"
    # end
    
    it 'has a name equal to "default venue"' do
      venue_search.name.must_equal "Aloha Isle"
      # subject.name.must_equal "Aloha Isle"
    end

    it 'has a string as an ID' do
      venue_search.id.must_be_kind_of String
    end

    it 'has a string as an address' do
      venue_search.location.formattedAddress.must_be_kind_of Array
    end

    it 'has a string as a crossStreet' do
      venue_search.location.crossStreet.must_be_kind_of String
    end

    it 'has a Float as a lat' do
      venue_search.location.lat.must_be_kind_of Float
    end

    it 'has a Float as a lng' do
      venue_search.location.lat.must_be_kind_of Float
    end

  end

  describe '#find WDW eatery that foursquare.com spells differently and FoursquareBridge knows' do
    venue_name = "Cheshire Cafe"
    subject { FoursquareGuaranteedVenue.find(venue_name) }
    let(:venue_search) { subject.first }
    # it 'does something' do
    #   subject.must_equal "something"
    # end
    
    it 'has a name equal to "default venue"' do
      venue_search.name.must_equal "Cheshire Café"
    end

    it 'has a string as an ID' do
      venue_search.id.must_be_kind_of String
    end

    it 'has a string as an address' do
      venue_search.location.formattedAddress.must_be_kind_of Array
    end

    it 'has a string as a crossStreet' do
      venue_search.location.crossStreet.must_be_kind_of String
    end

    it 'has a Float as a lat' do
      venue_search.location.lat.must_be_kind_of Float
    end

    it 'has a Float as a lng' do
      venue_search.location.lat.must_be_kind_of Float
    end

  end

end
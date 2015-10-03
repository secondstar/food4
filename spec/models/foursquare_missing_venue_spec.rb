require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/foursquare_missing_venue.rb'


describe FoursquareMissingVenue do
  subject { FoursquareMissingVenue.new }

  describe '#name ' do
    it 'returns "default venue"' do
      subject.name.must_equal "default venue"
    end
  end
  describe '#categories' do
    #<Hashie::Mash icon=#<Hashie::Mash prefix="https://ss3.4sqi.net/img/categories_v2/travel/busstation_" suffix=".png"> id="" name="" pluralName="" primary=true shortName="">
    let(:cat) { subject.categories }

    # it 'does something' do
    #   cat.must_equal "something"
    # end
    
    it 'is a Hashie::Mash ' do
      cat.must_be_kind_of Hashie::Mash
    end
    
    it 'has icon as a Hashie::Mash ' do
      cat.icon.must_be_kind_of Hashie::Mash
    end
    
    it 'has icon prefix as an static String ' do
      cat.icon.prefix.must_equal "https://ss3.4sqi.net/img/categories_v2/travel/busstation_"
    end
    
    it 'has icon prefix as an static String ' do
      cat.icon.suffix.must_equal ".png"
    end
    
    it 'has an id as a empty string ' do
      cat.id.must_equal ""
    end

    it 'has a pluralName as a empty string ' do
      cat.pluralName.must_equal ""
    end

    it 'has primary as true ' do
      cat.primary.must_equal true
    end

    it 'has a pluralName as a empty string ' do
      cat.shortName.must_equal ""
    end

  end
  
  describe '#location' do
    # location=#<Hashie::Mash cc="US" city="Lake Buena Vista" country="United States" crossStreet="all over Walt Disney World" distance=182 formattedAddress=["all over Walt Disney World", "Lake Buena Vista, FL 32830", "United States"] lat=28.37852393229888 lng=-81.56662923700945 postalCode="32830" state="FL"> 

    let(:loc) { subject.location }
    
    # it 'does something' do
    #   loc.must_equal "someting"
    # end
    
    it 'is a kind of Hashie::Mash ' do
      loc.must_be_kind_of Hashie::Mash
    end
    
    it 'has a length of 10 ' do
      loc.length.must_equal 10
    end
    
    it 'has a float for the lat ' do
      loc.lat.must_be_kind_of Float
    end

    it 'has a float for the lng ' do
      loc.lng.must_be_kind_of Float
    end
    
    it 'has an array for formattedAddress ' do
      loc.formattedAddress.must_be_kind_of Array
    end
  end
  
  describe '#id' do
    it 'is a String ' do
      subject.id.must_be_kind_of String
    end
  end
  
  describe '#referralId' do
    it 'is a String ' do
      subject.referralId.must_be_kind_of String
    end
  end
  
  describe '#specials' do
    it 'is a kind of Hashie::Mash ' do
      subject.specials.must_be_kind_of Hashie::Mash
    end
  end
  
  describe '#stats' do
    it 'is a kind of Hashie::Mash' do
      subject.stats.must_be_kind_of Hashie::Mash
    end
  end
  
  describe '#verified' do
    it 'is a kind of FalseClass' do
      subject.verified.must_be_kind_of FalseClass
    end
    
  end
  
end
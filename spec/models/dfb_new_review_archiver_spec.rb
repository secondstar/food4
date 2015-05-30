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
    
    it 'has "Counter Service" for Service' do
      subject['service'].must_equal "Counter Service"
    end
    
    it 'has "Magic Kingdom, Fantasyland" for "location"' do
      subject['location'].must_equal "Magic Kingdom, Fantasyland"
    end
    
    it 'has "disney_dining_plan" as "Yes, Snack Items' do
      subject['disney_dining_plan'].must_equal "Yes, Snack Items"
    end
    
    it 'has "Snacks and drinks" for type_of_food' do
      subject['type_of_food'].must_equal "Snacks and drinks"
    end
    
    it 'has "tables_in_wonderland" as "No"' do
      subject['tables_in_wonderland'].must_equal "No"
    end
    
    it 'has 2 links for "menu"' do
      subject['menu'].must_equal "<br>
<a href=\"https://disneyworld.disney.go.com/dining/magic-kingdom/cheshire-cafe/menus/\" target=\"_blank\">Official Disney Menu</a>"
    end
    
  end
  
  describe '#store golden path' do
    let(:permalink) {"cheshire-cafe"}
    let(:eatery_name) {"Cheshire Cafe"}
    subject { @dnra.store }
    
    it 'returns an Array' do
      subject.must_be_kind_of Array
    end

    it 'has 14 element' do
      subject.length.must_equal 14
    end
    
    it 'has a Hash for the first element' do
      subject.first.must_be_kind_of Hash
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


  describe '#store Whispering Canyon Cafe' do
    let(:permalink) {"whispering-canyon-cafe"}
    let(:eatery_name) {"Whispering Canyon Cafe"}
    subject { @dnra.store }

    # it 'works' do
    #   subject.must_equal "something"
    # end

    it 'returns an Array' do
      subject.must_be_kind_of Array
    end

    it 'has 15 elements' do
      subject.length.must_equal 15
    end
    
    it 'has a Hash for the first element' do
      subject.first.must_be_kind_of Hash
    end
  end

end
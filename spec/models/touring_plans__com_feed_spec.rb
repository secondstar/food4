# require 'minitest/autorun'
require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/touring_plans_com_feed'
require "ostruct"

describe TouringPlansComFeed do
  # let(:url) { "http://www.disneyfoodblog.com/disney-world-restaurants-guide"}
    
  describe "#get_eatery_details_by_permalink with 200 response code" do
    let(:district) { OpenStruct.new(:name => "Animal Kingdom") }
    let(:eatery)   { OpenStruct.new(:permalink => "mr-kamals", :menu_type_permalink => "")
}
    subject { TouringPlansComFeed.new(district, eatery).get_eatery_details_by_permalink }

    # it 'works' do
    #   subject.must_equal "something"
    # end
    
    it 'is a Hash' do
      subject.must_be_kind_of Hash
    end

    it "returns 45 items" do
      subject.length.must_equal 45
    end
    
    it 'has a permalink' do
      subject["permalink"].must_equal "mr-kamals"
    end
    
    it 'has a name' do
      subject["name"].must_equal "Mr. Kamal's"
    end

  end

  describe "#get_eatery_details_by_permalink with 400 response code" do
    let(:district) { OpenStruct.new(:name => "Animal Kingdom") }
    let(:eatery)   { OpenStruct.new(:permalink => "tamu-tamu2", :menu_type_permalink => "")
}
    subject { TouringPlansComFeed.new(district, eatery).get_eatery_details_by_permalink }

    # it 'works' do
    #   subject.must_equal "something"
    # end
    
    it 'is a Hash' do
      subject.must_be_kind_of Hash
    end

    it "returns 45 items" do
      subject.length.must_equal 45
    end

    it 'has a permalink' do
      subject["permalink"].must_equal "tamu-tamu2"
    end

    it 'has a name' do
      subject["name"].must_equal "tamu tamu2"
    end

  end
end
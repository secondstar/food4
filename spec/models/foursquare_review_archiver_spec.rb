require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/foursquare_review_archiver'
require "ostruct"

describe FoursquareReviewArchiver do

  let(:eatery_id) { 493 }
  let(:foursquare_review_attrs) { {:foursquare_id=>"4b3b989ff964a520b97625e3", :name=>"Flame Tree Barbecue", :address=>"Discovery Island, Animal Kingdom", :cross_street=>"Walt Disney World", :lat=>28.357443702097292, :lng=>-81.58961318666955, :alt_venues=>"Flame Tree Barbecue", :searched_for=>"Flame Tree Barbecue"} }
  subject { FoursquareReviewArchiver.new(eatery_id, foursquare_review_attrs) }

  describe '#archive_scanned_in_review' do
    subject { FoursquareReviewArchiver.new(eatery_id, foursquare_review_attrs) }
    let(:scanned_review) { subject.archive_scanned_in_review }

    # it 'does something' do
    #   scanned_review.must_equal "something"
    # end
    
    it 'returns a kind of FoursquareReview' do
      scanned_review.must_be_kind_of FoursquareReview
    end
  end
  
  describe '#_connect_snapshot_to_eatery' do
    let(:foursquare_review) { FoursquareReview.create(name: "tofu") }
    subject { FoursquareReviewArchiver.new(eatery_id, foursquare_review_attrs) }
    let(:connecting_snapshot) { subject._connect_snapshot_to_eatery(foursquare_review) }
    
    # it 'does something' do
    #   connecting_snapshot.must_equal "something"
    # end
    
    it 'returns a kind of Snapshot' do
      connecting_snapshot.must_be_kind_of Snapshot
    end

    it 'returns a Fixnum for eatery_id' do
      connecting_snapshot.eatery_id.must_be_kind_of Fixnum
    end

    it 'returns a Fixnum for review_id' do
      connecting_snapshot.review_id.must_be_kind_of Fixnum
    end

    it 'returns a "FoursquareReview" for review_type' do
      connecting_snapshot.review_type.must_equal "FoursquareReview"
    end
  end
  
  describe '#store' do
    subject { FoursquareReviewArchiver.new(eatery_id, foursquare_review_attrs) }
    let(:stored_review) { subject.store }
    # it 'does something' do
    #   stored_review.must_equal "something"
    # end
    
    it 'returns a kind of Snapshot' do
      stored_review.must_be_kind_of Snapshot
    end

    it 'returns a Fixnum for eatery_id' do
      stored_review.eatery_id.must_be_kind_of Fixnum
    end

    it 'returns a Fixnum for review_id' do
      stored_review.review_id.must_be_kind_of Fixnum
    end

    it 'returns a "FoursquareReview" for review_type' do
      stored_review.review_type.must_equal "FoursquareReview"
    end
    
  end
end
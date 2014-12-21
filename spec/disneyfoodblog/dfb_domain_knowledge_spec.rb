require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/disneyfoodblog/dfb_domain_knowledge'
require "ostruct"

describe DfbDomainKnowledge do
  
  subject { DfbDomainKnowledge.new }
  
  describe '#i_know_from_404' do
    it 'is a Hash' do
      subject.i_know_from_404.must_be_kind_of Hash
    end
    
    it 'has at least one element' do
      subject.i_know_from_404.size.must_be :>=, 1
    end
  end
  
  describe '#i_know_normal_scrape_does_not_work' do
    it 'is an Array' do
      subject.i_know_normal_scrape_does_not_work.must_be_kind_of Array
    end

    it 'has at least one element' do
      subject.i_know_normal_scrape_does_not_work.size.must_be :>=, 1
    end
  end

  describe '#i_know_these_links_are_not_listed_on_site' do
    it 'is a Hash' do
      subject.i_know_these_links_are_not_listed_on_site.must_be_kind_of Hash
    end
    
    it 'has at least 10 element' do
      subject.i_know_these_links_are_not_listed_on_site.size.must_be :>=, 10
    end
  end

end

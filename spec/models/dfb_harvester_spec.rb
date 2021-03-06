require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_harvester'
require "ostruct"

describe DfbHarvester do
  before do
    params = {path: permalink, 
      yql_css_parse: ".entry-content"     
    }
    target = OpenStruct.new(params)
    @it = DfbHarvester.new(target)
    # target.doc = Nokogiri::HTML(open(@it.yql_url))
    
    # doc = Nokogiri::HTML(open("https://query.yahooapis.com/v1/public/yql?q=use%20'https%3A%2F%2Fraw.githubusercontent.com%2Fyql%2Fyql-tables%2Fmaster%2Fdata%2Fdata.html.cssselect.xml'%20as%20cssselect%3B%20select%20*%20from%20cssselect%20where%20url%3D%20'http%3A%2F%2Fwww.disneyfoodblog.com%2F#{URI.escape(target.path)}'%20and%20css%20%3D%20'#{URI.escape(target.yql_css_parse)}'&diagnostics=true"))
    # puts "@it is #{@it}"
    # puts "@target is #{@target}"
  end


  describe "#yql_url" do
    let(:permalink) { "whispering-canyon-cafe" }
    subject { @it.yql_url }
    it "works" do
      # puts "\n yql_url: #{@it.yql_url} \n"
      
      subject.must_equal "https://query.yahooapis.com/v1/public/yql?q=select+*+from+data.html.cssselect+where+url%3D%27http%3A%2F%2Fwww.disneyfoodblog.com%2Fwhispering-canyon-cafe%27+AND+css%3D%27.entry-content%27&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    end
  end
  
  describe "#scan_for_tips" do
    let(:permalink) { "whispering-canyon-cafe" }
    subject { @it.scan_for_tips(doc = Nokogiri::HTML(open(@it.yql_url))) }
    
    # # it "works" do
    # #   subject.must_equal [{"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"", "description"=>"<li>You never know what’s going to happen at WCC — servers are on the lookout for ways to have fun with guests.</li>", "category"=>"tips"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"", "description"=>"<li>Surprising things happen when you ask for Ketchup…</li>", "category"=>"tips"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"", "description"=>"<li>Try to make a reservation for prime mealtimes. When the restaurant is full is when things are most fun.</li>", "category"=>"tips"}]
    #
    # end
    
    it 'is an Array' do
      subject.must_be_kind_of Array
    end
    
    it 'has a Hash nested in the Array' do
      subject[0].must_be_kind_of Hash
    end
    
    it 'has 4 elements in the nested Hash' do
      subject[0].length.must_equal 4
    end
    
    it 'does something' do
      
    end
    
    it 'has four keys in the first element which is a hash' do
      subject[0].keys.length.must_equal 4
    end
  end
  #
  # describe "#scan_for_bloggings" do
  #
  #   before do
  #     sleep(2.seconds)
  #   end
  #
  #   it 'is a Enumerable' do
  #     @it.scan_for_bloggings.must_be_kind_of Enumerable
  #   end
  #
  #   it "returns 10 results" do
  #     @it.scan_for_bloggings.length.must_equal 10
  #   end
  #
  #   it 'has the first result as a hash' do
  #     @it.scan_for_bloggings.first.must_be_kind_of Hash
  #
  #   end
  #
  #   it 'lists 4 items in the hash' do
  #     @it.scan_for_bloggings.first.length.must_equal 4
  #   end
  #
  #
  # end
  #
  # describe "#scan_for_affinities" do
  #   before do
  #     sleep(2.seconds)
  #   end
  #   it "works" do
  #     @it.scan_for_affinities.must_equal  [
  #       {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/",
  #          "href"=>"http://www.disneyfoodblog.com/hoop-dee-doo-revue/",
  #          "description"=>"Hoop Dee Doo Revue",
  #          "category"=>"affinity"},
  #       {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/",
  #         "href"=>"http://www.disneyfoodblog.com/trails-end-restaurant/",
  #         "description"=>"Trail’s End Restaurant",
  #         "category"=>"affinity"}
  #     ]
  #
  #   end
  # end
  #
  #
  # describe "#scan_for_addendums" do
  #   before do
  #     sleep(2.seconds)
  #   end
  #
  #   it "has exactly 15 items" do
  #     @it.scan_for_addendums.length.must_equal 15
  #   end
  #
  # end
end
require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_harvester'
require "ostruct"

describe DfbHarvester do
  before do
    params = {path: "whispering-canyon-cafe", 
      yql_css_parse: "#primary .entry-content"     
    }
    target = OpenStruct.new(params)
    @it = DfbHarvester.new(target)
    doc = Nokogiri::HTML(open("https://query.yahooapis.com/v1/public/yql?q=use%20'https%3A%2F%2Fraw.githubusercontent.com%2Fyql%2Fyql-tables%2Fmaster%2Fdata%2Fdata.html.cssselect.xml'%20as%20cssselect%3B%20select%20*%20from%20cssselect%20where%20url%3D%20'http%3A%2F%2Fwww.disneyfoodblog.com%2F#{URI.escape(target.path)}'%20and%20css%20%3D%20'#{URI.escape(target.yql_css_parse)}'&diagnostics=true"))
    # puts "@it is #{@it}"
    # puts "@target is #{@target}"
  end

  describe "#yql_url" do
    before do
      # puts "\nyql_url: #{@it.yql_url}\n"
    end
    it "works" do
      # puts "\n yql_url: #{@it.yql_url} \n"
      
      @it.yql_url.must_equal "https://query.yahooapis.com/v1/public/yql?q=use%20'https%3A%2F%2Fraw.githubusercontent.com%2Fyql%2Fyql-tables%2Fmaster%2Fdata%2Fdata.html.cssselect.xml'%20as%20cssselect%3B%20select%20*%20from%20cssselect%20where%20url%3D%20'http%3A%2F%2Fwww.disneyfoodblog.com%2Fwhispering-canyon-cafe'%20and%20css%20%3D%20'%23primary%20.entry-content'&diagnostics=true"
    end
  end
  
  describe "#scan_for_tips" do
    before do
      sleep(2.seconds)
    end
    it "works" do
      @it.scan_for_tips.must_equal [{"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"", "description"=>"You never know what’s going to happen at WCC — servers are on the lookout for ways to have fun with guests.", "category"=>"tips"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"", "description"=>"Surprising things happen when you ask for Ketchup…", "category"=>"tips"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"", "description"=>"Try to make a reservation for prime mealtimes. When the restaurant is full is when things are most fun.", "category"=>"tips"}]

    end
  end

  describe "#scan_for_bloggings" do
    
    before do
      sleep(2.seconds)
    end
    it "works" do
      @it.scan_for_bloggings.must_equal [{"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2014/05/11/review-dinner-at-whispering-canyon-cafe-in-disneys-wilderness-lodge/", "description"=>"Review: Dinner at Whispering Canyon Cafe in Disney’s Wilderness Lodge", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2014/01/22/three-must-try-disney-pies/", "description"=>"Three Must-Try Disney Pies!", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2013/09/24/the-weirdest-burgers-in-disney-world/", "description"=>"The Weirdest Burgers in Disney World", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2013/07/22/disney-popcorn-gallery/", "description"=>"Disney Popcorn Gallery", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2013/07/15/disney-food-blog-challenge-the-disney-world-milkshake-crawl/", "description"=>"Disney Food Blog Challenge: The Disney World Milkshake Crawl", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2013/06/25/our-ten-favorite-frozen-drinks-in-disney-world/", "description"=>"Ten Best Frozen Drinks in Disney World", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2013/05/16/the-most-popular-disney-restaurants-and-alternatives-when-theyre-full/", "description"=>"The Most Popular Disney World Restaurants (and Alternatives When They’re Full)", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2012/10/28/review-new-lunch-menu-at-whispering-canyon-cafe-in-disneys-wilderness-lodge/", "description"=>"Review: New Lunch Menu at Whispering Canyon Cafe in Disney’s Wilderness Lodge", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2012/09/22/disney-food-post-round-up-september-23-2012/", "description"=>"Disney Food Post Round-Up: September 23, 2012", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2012/09/22/news-whispering-canyon-cafe-changes-it-up-with-new-menus/", "description"=>"News! Whispering Canyon Cafe Changes It Up With New Menus", "category"=>"blogging"}]
    end
  end

  describe "#scan_for_affinities" do
    before do
      sleep(2.seconds)
    end
    it "works" do
      @it.scan_for_affinities.must_equal  [
        {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/",
           "href"=>"http://www.disneyfoodblog.com/hoop-dee-doo-revue/", 
           "description"=>"Hoop Dee Doo Revue", 
           "category"=>"affinity"}, 
        {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", 
          "href"=>"http://www.disneyfoodblog.com/trails-end-restaurant/", 
          "description"=>"Trail’s End Restaurant", 
          "category"=>"affinity"}
      ] 
    end
  end

  
  describe "#scan_for_addendums" do
    before do
      sleep(2.seconds)
    end
    it "works" do
      @it.scan_for_addendums.must_equal [{"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"", "description"=>"You never know what’s going to happen at WCC — servers are on the lookout for ways to have fun with guests.", "category"=>"tips"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"", "description"=>"Surprising things happen when you ask for Ketchup…", "category"=>"tips"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"", "description"=>"Try to make a reservation for prime mealtimes. When the restaurant is full is when things are most fun.", "category"=>"tips"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2014/05/11/review-dinner-at-whispering-canyon-cafe-in-disneys-wilderness-lodge/", "description"=>"Review: Dinner at Whispering Canyon Cafe in Disney’s Wilderness Lodge", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2014/01/22/three-must-try-disney-pies/", "description"=>"Three Must-Try Disney Pies!", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2013/09/24/the-weirdest-burgers-in-disney-world/", "description"=>"The Weirdest Burgers in Disney World", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2013/07/22/disney-popcorn-gallery/", "description"=>"Disney Popcorn Gallery", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2013/07/15/disney-food-blog-challenge-the-disney-world-milkshake-crawl/", "description"=>"Disney Food Blog Challenge: The Disney World Milkshake Crawl", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2013/06/25/our-ten-favorite-frozen-drinks-in-disney-world/", "description"=>"Ten Best Frozen Drinks in Disney World", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2013/05/16/the-most-popular-disney-restaurants-and-alternatives-when-theyre-full/", "description"=>"The Most Popular Disney World Restaurants (and Alternatives When They’re Full)", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2012/10/28/review-new-lunch-menu-at-whispering-canyon-cafe-in-disneys-wilderness-lodge/", "description"=>"Review: New Lunch Menu at Whispering Canyon Cafe in Disney’s Wilderness Lodge", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2012/09/22/disney-food-post-round-up-september-23-2012/", "description"=>"Disney Food Post Round-Up: September 23, 2012", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/2012/09/22/news-whispering-canyon-cafe-changes-it-up-with-new-menus/", "description"=>"News! Whispering Canyon Cafe Changes It Up With New Menus", "category"=>"blogging"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/hoop-dee-doo-revue/", "description"=>"Hoop Dee Doo Revue", "category"=>"affinity"}, {"source"=>"http://www.disneyfoodblog.com/whispering-canyon-cafe/", "href"=>"http://www.disneyfoodblog.com/trails-end-restaurant/", "description"=>"Trail’s End Restaurant", "category"=>"affinity"}]
    end

  end
end